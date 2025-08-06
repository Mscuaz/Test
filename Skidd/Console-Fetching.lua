a = {}
function a:Console(v)
	local ConsoleFFF = Instance.new("ScreenGui")
	local Frame_1 = Instance.new("Frame")
	local DropShadow_1 = Instance.new("ImageLabel")
	local UICorner_1 = Instance.new("UICorner")
	local UIGradient_1 = Instance.new("UIGradient")
	local UIStroke_1 = Instance.new("UIStroke")
	local ImageLabel_1 = Instance.new("ImageLabel")

	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local function tw(info)
		return TweenService:Create(
			info.v, 
			TweenInfo.new(info.t, Enum.EasingStyle[info.s], Enum.EasingDirection[info.d]), 
			info.g
		)
	end
	local function lak(a)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function Update(input)
			local Delta = input.Position - DragStart
			local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
			local Tween = game:GetService("TweenService"):Create(a, TweenInfo.new(0.3), {Position = pos})
			Tween:Play()
		end

		a.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = a.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		a.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				DragInput = input
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end)
	end
	local function click(p)
		local Click = Instance.new("TextButton")

		Click.Name = "Click"
		Click.Parent = p
		Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click.BackgroundTransparency = 1.000
		Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click.BorderSizePixel = 0
		Click.Size = UDim2.new(1, 0, 1, 0)
		Click.Font = Enum.Font.SourceSans
		Click.Text = ""
		Click.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click.TextSize = 14.000

		return Click
	end
	local function ButtoneffectClick(c, p)
		local Mouse = game.Players.LocalPlayer:GetMouse()

		local relativeX = Mouse.X - c.AbsolutePosition.X
		local relativeY = Mouse.Y - c.AbsolutePosition.Y

		if relativeX < 0 or relativeY < 0 or relativeX > c.AbsoluteSize.X or relativeY > c.AbsoluteSize.Y then
			return
		end

		local ClickButtonCircle = Instance.new("Frame")
		ClickButtonCircle.Parent = p
		ClickButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ClickButtonCircle.BackgroundTransparency = 0.7
		ClickButtonCircle.BorderSizePixel = 0
		ClickButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
		ClickButtonCircle.Position = UDim2.new(0, relativeX, 0, relativeY)
		ClickButtonCircle.Size = UDim2.new(0, 0, 0, 0)
		ClickButtonCircle.ZIndex = 10

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = ClickButtonCircle

		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local goal = {
			Size = UDim2.new(0, c.AbsoluteSize.X * 1.5, 0, c.AbsoluteSize.X * 1.5),
			BackgroundTransparency = 1
		}

		local expandTween = game:GetService("TweenService"):Create(ClickButtonCircle, tweenInfo, goal)

		expandTween.Completed:Connect(function()
			ClickButtonCircle:Destroy()
		end)

		expandTween:Play()
	end

	ConsoleFFF.Name = "ConsoleFFF"
	ConsoleFFF.Parent = not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui
	ConsoleFFF.ZIndexBehavior = Enum.ZIndexBehavior.Global
	ConsoleFFF.IgnoreGuiInset = true

	Frame_1.Parent = ConsoleFFF
	Frame_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_1.BorderSizePixel = 0
	Frame_1.Position = UDim2.new(0.05, 0,0.3, 0)
	Frame_1.Size = UDim2.new(0, 60,0, 60)
	Frame_1.Visible = v

	lak(Frame_1)
	local clickz = click(ImageLabel_1)

	DropShadow_1.Name = "DropShadow"
	DropShadow_1.Parent = Frame_1
	DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_1.BackgroundColor3 = Color3.fromRGB(28,28,30)
	DropShadow_1.BackgroundTransparency = 1
	DropShadow_1.BorderColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.BorderSizePixel = 0
	DropShadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
	DropShadow_1.Size = UDim2.new(1, 70,1, 70)
	DropShadow_1.ZIndex = 0
	DropShadow_1.Image = "rbxassetid://8992230677"
	DropShadow_1.ImageColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.ImageTransparency = 0.25
	DropShadow_1.ScaleType = Enum.ScaleType.Slice
	DropShadow_1.SliceCenter = Rect.new(99, 99, 99, 99)

	UICorner_1.Parent = Frame_1
	UICorner_1.CornerRadius = UDim.new(0,15)

	UIGradient_1.Parent = Frame_1
	UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(9, 9, 9)), ColorSequenceKeypoint.new(1, Color3.fromRGB(42, 42, 42))}
	UIGradient_1.Offset = Vector2.new(-0.200000003, 0)
	UIGradient_1.Rotation = -26

	UIStroke_1.Parent = Frame_1
	UIStroke_1.Color = Color3.fromRGB(74,74,74)
	UIStroke_1.Thickness = 2

	ImageLabel_1.Parent = Frame_1
	ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel_1.BackgroundTransparency = 1
	ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel_1.BorderSizePixel = 0
	ImageLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
	ImageLabel_1.Size = UDim2.new(0, 30,0, 30)
	ImageLabel_1.Image = "rbxassetid://116121048695649"

	clickz.MouseButton1Click:Connect(function()
		game:GetService('StarterGui'):SetCore("DevConsoleVisible", true)
		ButtoneffectClick(clickz, Frame_1)
		tw({
			v = ImageLabel_1,
			t = 0.2,
			s = "Back",
			d = "Out",
			g = {Size = UDim2.new(0, 20, 0, 20)}
		}):Play()
		task.wait(0.016) 
		tw({
			v = ImageLabel_1,
			t = 0.2,
			s = "Back",
			d = "Out",
			g = {Size = UDim2.new(0, 30, 0, 30)}
		}):Play()
	end)
	
	local new = {}
	
	function new:SetVisible(l)
		Frame_1.Visible = l
	end
	
	return new
end
return a
