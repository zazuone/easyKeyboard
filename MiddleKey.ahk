;************************
;*	鼠标中键自由拖拽窗口	*
;*	网页中键后台打开页面	*
;*	双击中键置顶窗口状态	*
;*	窗口拖拽撞击边缘实现	*
;*	自动左右分屏、最大化	*
;*			by Zz乛_乛	*
;************************
#If !WinActive("ahk_class Warcraft III") && !WinActive("ahk_class SDL_app") ;war3/dota2下屏蔽
	MButton:: ; 如不屏蔽中键原功能在前缀加~，但这样拖拽窗口时会实时激活
		CoordMode,Mouse ; 切换到屏幕绝对坐标
		MouseGetPos,Zz_MouseStartX,Zz_MouseStartY,Zz_MouseWin
		WinGet,winstat,MinMax,ahk_id %Zz_MouseWin%
		if(winstat<>1){
			WinGetPos,Zz_OldPosX,Zz_OldPosY,Zz_OldWidth,Zz_OldHeight,ahk_id %Zz_MouseWin%
			SetTimer,Zz_WatchMouse,10 ; 跟踪鼠标拖拽
		}else if(WinActive("ahk_class Chrome_WidgetWin_1")){ ; 浏览器不最大化中键仍为拖拽
			Send,^{LButton} ; 【网页中键后台打开】(默认为浏览器最大化时)
		}
		KeyWait,MButton,,t0.2 ; 双击判断，等待第二次按键
		if(errorlevel<>1){
			KeyWait,MButton,d,t0.2 ; 判断第二次按键是否是鼠标中键
			if(errorlevel=0){
				WinSet,AlwaysOnTop,Toggle,ahk_id %Zz_MouseWin% ; 【切换窗口置顶】
			}
		}
	return
	Zz_WatchMouse:
		GetKeyState,Zz_MButtonState,MButton,P
		if Zz_MButtonState=U ; 释放则完成
		{
			SetTimer,Zz_WatchMouse,off
			if(Zz_Drag){ ; 窗口贴边时中键释放则记录宽高
				Zz_Width_%Zz_MouseWin%:=Zz_OldWidth
				Zz_Height_%Zz_MouseWin%:=Zz_OldHeight
			}
			return
		}
		GetKeyState,Zz_EscapeState,Escape,P
		if Zz_EscapeState=D ; 按Esc则还原
		{
			SetTimer,Zz_WatchMouse,off
			WinMove,ahk_id %Zz_MouseWin%,,%Zz_OldPosX%,%Zz_OldPosY%,%Zz_OldWidth%,%Zz_OldHeight%
			return
		}
		; 【重新定位该窗口以匹配鼠标坐标的变化：】
		CoordMode,Mouse
		SetWinDelay,-1 ; 使得窗口移动无延迟
		MouseGetPos,Zz_MouseX,Zz_MouseY
		WinGetPos,Zz_WinX,Zz_WinY,Zz_Width,Zz_Height,ahk_id %Zz_MouseWin%
		; 【窗口拖拽撞击边缘自动左右分屏、最大化：】
		Drag_B:=-5	; 超出边缘像素边界(负数)
		Drag_V:=-50	; 超出边缘像素范围(负数)
		Drag_N:=200	; 超出边缘忽略界限(正数)
		Drag_T:=1	; 生效时间能量点(10ms/个)
		if(!Zz_Drag){	; 拖拽状态
			if(Zz_MouseStartX<Zz_MouseX && Zz_WinX>(A_ScreenWidth-Zz_Width-Drag_B) && Zz_WinX<(A_ScreenWidth-Zz_Width-Drag_V)){
				; 撞右屏边缘
				Zz_Time+=1
				if(Zz_Time>=Drag_T){
					Zz_Right:=true
					Zz_Drag:=true
					Zz_Time:=0
					Zz_Drag_XY()
					WinMove,ahk_id %Zz_MouseWin%,,A_ScreenWidth/2,0,A_ScreenWidth/2,A_ScreenHeight
				}
			}else if(Zz_MouseStartX>Zz_MouseX && Zz_WinX<Drag_B && Zz_WinX>Drag_V){ ; 撞左屏边缘
				Zz_Time+=1
				if(Zz_Time>=Drag_T){
					Zz_Left:=true
					Zz_Drag:=true
					Zz_Time:=0
					Zz_Drag_XY()
					WinMove,ahk_id %Zz_MouseWin%,,0,0,A_ScreenWidth/2,A_ScreenHeight
				}
			}else if(Zz_MouseStartY>Zz_MouseY && Zz_WinY<Drag_B && Zz_WinY>Drag_V){ ; 撞上屏边缘
				Zz_Time+=1
				if(Zz_Time>=Drag_T){
					Zz_Top:=true
					Zz_Drag:=true
					Zz_Time:=0
					Zz_Drag_XY()
					WinMaximize,ahk_id %Zz_MouseWin%
				}
			}
		}else{ ; 撞过忽略界限像素或往回拖拽则还原窗口
			if(Zz_Right && (Zz_MouseX<Drag_MouseX || Zz_MouseX>(Drag_MouseX+Drag_N))){ ; 右屏还原
				Zz_WinX:=Drag_WinX
				if(Zz_MouseX>(Drag_MouseX+Drag_N))
					Zz_WinX+=Drag_N
				Zz_WinY:=Drag_WinY
				Zz_Right:=false
				Zz_Drag:=false
			}else if(Zz_Left && (Zz_MouseX>Drag_MouseX || Zz_MouseX<(Drag_MouseX-Drag_N))){ ; 左屏还原
				Zz_WinX:=Drag_WinX
				if(Zz_MouseX<(Drag_MouseX-Drag_N))
					Zz_WinX-=Drag_N
				Zz_WinY:=Drag_WinY
				Zz_Left:=false
				Zz_Drag:=false
			}else if(Zz_Top && (Zz_MouseY>Drag_MouseY || Zz_MouseY<(Drag_MouseY-Drag_N))){ ; 最大化还原
				WinGet,winstat,MinMax,ahk_id %Zz_MouseWin%
				if(winstat=1)
					WinRestore,ahk_id %Zz_MouseWin%
				Zz_WinX:=Drag_WinX
				Zz_WinY:=Drag_WinY
				if(Zz_MouseY<(Drag_MouseY-Drag_N))
					Zz_WinY-=Drag_N
				Zz_Top:=false
				Zz_Drag:=false
			}
			if(Zz_Width_%Zz_MouseWin% && Zz_Height_%Zz_MouseWin%){ ; 在窗口贴边时拖拽窗口还原宽高
				Zz_OldWidth:=Zz_Width_%Zz_MouseWin%
				Zz_OldHeight:=Zz_Height_%Zz_MouseWin%
				Zz_Width_%Zz_MouseWin%:=false
				Zz_Height_%Zz_MouseWin%:=false
			}
		}
		; 移动窗体
		if(!Zz_Drag){
			WinMove,ahk_id %Zz_MouseWin%,,Zz_WinX+Zz_MouseX-Zz_MouseStartX,Zz_WinY+Zz_MouseY-Zz_MouseStartY,Zz_OldWidth,Zz_OldHeight
		}
		; 更新坐标
		Zz_MouseStartX:=Zz_MouseX
		Zz_MouseStartY:=Zz_MouseY
	return
	Zz_Drag_XY(){
		global
		Drag_MouseX:=Zz_MouseX
		Drag_MouseY:=Zz_MouseY
		Drag_WinX:=Zz_WinX
		Drag_WinY:=Zz_WinY
	}
#If
