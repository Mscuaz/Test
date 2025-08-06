-- GUI to Lua 
-- Version: 0.0.3

-- Instances:
as = {}

function as:Executor(v,save)
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
	local Scripting = Instance.new("ScreenGui")
	local Main_1 = Instance.new("Frame")
	local UICorner_1 = Instance.new("UICorner")
	local UIStroke_1 = Instance.new("UIStroke")
	local DropShadow_1 = Instance.new("ImageLabel")
	local Effect_1 = Instance.new("ImageLabel")
	local fire_1 = Instance.new("Frame")
	local Frame_1 = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local ImageLabel_1 = Instance.new("ImageLabel")
	local UIListLayout_1 = Instance.new("UIListLayout")
	local Frame_2 = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local ImageLabel_2 = Instance.new("ImageLabel")
	local Frame_3 = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ImageLabel_3 = Instance.new("ImageLabel")
	local Code_1 = Instance.new("Frame")
	local TextBox_1 = Instance.new("TextBox")
	local UICorner_5 = Instance.new("UICorner")
	local Exec_1 = Instance.new("Frame")
	local UICorner_6 = Instance.new("UICorner")
	local TextLabel_1 = Instance.new("TextLabel")

	-- Properties:
	Scripting.Name = "Scripting"
	Scripting.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	Scripting.ZIndexBehavior = Enum.ZIndexBehavior.Global
	Scripting.Enabled = v

	Main_1.Name = "Main"
	Main_1.Parent = Scripting
	Main_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Main_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Main_1.BackgroundTransparency = 0.699999988079071
	Main_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Main_1.BorderSizePixel = 0
	Main_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Main_1.Size = UDim2.new(0, 500,0, 375)
	
	lak(Main_1)

	UICorner_1.Parent = Main_1

	UIStroke_1.Parent = Main_1
	UIStroke_1.Color = Color3.fromRGB(255,255,255)
	UIStroke_1.Transparency = 0.7
	UIStroke_1.Thickness = 2

	DropShadow_1.Name = "DropShadow"
	DropShadow_1.Parent = Main_1
	DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_1.BackgroundColor3 = Color3.fromRGB(28,28,30)
	DropShadow_1.BackgroundTransparency = 1
	DropShadow_1.BorderColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.BorderSizePixel = 0
	DropShadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
	DropShadow_1.Size = UDim2.new(1, 120,1, 120)
	DropShadow_1.ZIndex = 0
	DropShadow_1.Image = "rbxassetid://8992230677"
	DropShadow_1.ImageColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.ImageTransparency = 0.25
	DropShadow_1.ScaleType = Enum.ScaleType.Slice
	DropShadow_1.SliceCenter = Rect.new(99, 99, 99, 99)

	Effect_1.Name = "Effect"
	Effect_1.Parent = Main_1
	Effect_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Effect_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Effect_1.BackgroundTransparency = 1
	Effect_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Effect_1.BorderSizePixel = 0
	Effect_1.Position = UDim2.new(0.547999978, 0,0.515999973, 0)
	Effect_1.Size = UDim2.new(0.856000006, 200,0.967999995, 200)
	Effect_1.Image = "rbxassetid://104034982402252"
	Effect_1.ImageTransparency = 0.7099999785423279

	fire_1.Name = "fire"
	fire_1.Parent = Main_1
	fire_1.AnchorPoint = Vector2.new(0.5, 0)
	fire_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	fire_1.BackgroundTransparency = 1
	fire_1.BorderColor3 = Color3.fromRGB(0,0,0)
	fire_1.BorderSizePixel = 0
	fire_1.Position = UDim2.new(0.5, 0,0.0240000002, 0)
	fire_1.Size = UDim2.new(0, 125,0, 16)

	Frame_1.Parent = fire_1
	Frame_1.BackgroundColor3 = Color3.fromRGB(0,255,127)
	Frame_1.BackgroundTransparency = 0.20000000298023224
	Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_1.BorderSizePixel = 0
	Frame_1.Size = UDim2.new(0, 10,0, 10)

	UICorner_2.Parent = Frame_1
	UICorner_2.CornerRadius = UDim.new(1,0)

	ImageLabel_1.Parent = Frame_1
	ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel_1.BackgroundTransparency = 1
	ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel_1.BorderSizePixel = 0
	ImageLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
	ImageLabel_1.Size = UDim2.new(1, 25,1, 25)
	ImageLabel_1.Image = "rbxassetid://110890831577968"
	ImageLabel_1.ImageColor3 = Color3.fromRGB(0,255,127)

	UIListLayout_1.Parent = fire_1
	UIListLayout_1.Padding = UDim.new(0.10000000149011612,0)
	UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

	Frame_2.Parent = fire_1
	Frame_2.BackgroundColor3 = Color3.fromRGB(255,255,0)
	Frame_2.BackgroundTransparency = 0.20000000298023224
	Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Size = UDim2.new(0, 10,0, 10)

	UICorner_3.Parent = Frame_2
	UICorner_3.CornerRadius = UDim.new(1,0)

	ImageLabel_2.Parent = Frame_2
	ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel_2.BackgroundTransparency = 1
	ImageLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel_2.BorderSizePixel = 0
	ImageLabel_2.Position = UDim2.new(0.5, 0,0.5, 0)
	ImageLabel_2.Size = UDim2.new(1, 25,1, 25)
	ImageLabel_2.Image = "rbxassetid://110890831577968"
	ImageLabel_2.ImageColor3 = Color3.fromRGB(255,255,0)

	Frame_3.Parent = fire_1
	Frame_3.BackgroundColor3 = Color3.fromRGB(255,0,0)
	Frame_3.BackgroundTransparency = 0.20000000298023224
	Frame_3.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_3.BorderSizePixel = 0
	Frame_3.Size = UDim2.new(0, 10,0, 10)

	UICorner_4.Parent = Frame_3
	UICorner_4.CornerRadius = UDim.new(1,0)

	ImageLabel_3.Parent = Frame_3
	ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel_3.BackgroundTransparency = 1
	ImageLabel_3.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel_3.BorderSizePixel = 0
	ImageLabel_3.Position = UDim2.new(0.5, 0,0.5, 0)
	ImageLabel_3.Size = UDim2.new(1, 25,1, 25)
	ImageLabel_3.Image = "rbxassetid://110890831577968"
	ImageLabel_3.ImageColor3 = Color3.fromRGB(255,0,0)

	Code_1.Name = "Code"
	Code_1.Parent = Main_1
	Code_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Code_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Code_1.BackgroundTransparency = 0.9800000190734863
	Code_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Code_1.BorderSizePixel = 0
	Code_1.Position = UDim2.new(0.5, 0,0.487666667, 0)
	Code_1.Size = UDim2.new(0.949999988, 0,0.791333258, 0)

	TextBox_1.Parent = Code_1
	TextBox_1.Active = true
	TextBox_1.AnchorPoint = Vector2.new(0.5, 0.5)
	TextBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TextBox_1.BackgroundTransparency = 1
	TextBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TextBox_1.BorderSizePixel = 0
	TextBox_1.CursorPosition = -1
	TextBox_1.Position = UDim2.new(0.5, 0,0.501901507, 0)
	TextBox_1.Size = UDim2.new(0.949999988, 0,0.926958621, 0)
	TextBox_1.Font = Enum.Font.Code
	TextBox_1.PlaceholderColor3 = Color3.fromRGB(120,120,120)
	TextBox_1.PlaceholderText = 'print("Hello world")'
	TextBox_1.RichText = true
	TextBox_1.Text = save
	TextBox_1.TextColor3 = Color3.fromRGB(255,255,255)
	TextBox_1.TextSize = 14
	TextBox_1.ClearTextOnFocus = false
	TextBox_1.TextWrapped = true
	TextBox_1.TextXAlignment = Enum.TextXAlignment.Left
	TextBox_1.TextYAlignment = Enum.TextYAlignment.Top

	UICorner_5.Parent = Code_1

	Exec_1.Name = "Exec"
	Exec_1.Parent = Main_1
	Exec_1.BackgroundColor3 = Color3.fromRGB(0,255,127)
	Exec_1.BackgroundTransparency = 0.4000000059604645
	Exec_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Exec_1.BorderSizePixel = 0
	Exec_1.Position = UDim2.new(0.72299999, 0,0.906666696, 0)
	Exec_1.Size = UDim2.new(0, 126,0, 28)
	
	local c = click(Exec_1)
	c.MouseButton1Click:Connect(function()
		ButtoneffectClick(c, Exec_1)
		local code = TextBox_1.Text
		local func, err = loadstring(code)
		if func then
			coroutine.wrap(func)()
		else
			warn("Syntax Error: " .. err)
		end
	end)

	UICorner_6.Parent = Exec_1

	TextLabel_1.Parent = Exec_1
	TextLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TextLabel_1.BackgroundTransparency = 1
	TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TextLabel_1.BorderSizePixel = 0
	TextLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
	TextLabel_1.Size = UDim2.new(1, 0,1, 0)
	TextLabel_1.Font = Enum.Font.GothamBold
	TextLabel_1.Text = "Execute"
	TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
	TextLabel_1.TextSize = 14
	
	local new = {}
	function new:SetVisible(b)
		Scripting.Enabled = b
	end
	return new
end

return as
