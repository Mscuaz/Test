local SikeHub = {}

local gui = Instance.new("ScreenGui")
gui.Name = "SikeHubGUI"
pcall(function() gui.Parent = game:FindFirstChildOfClass("CoreGui") end)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 0)
frame.Position = UDim2.new(0.5, -100, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.AutomaticSize = Enum.AutomaticSize.Y
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true
title.Text = "SIKE! HUB"
title.LayoutOrder = 0
title.Parent = frame

function SikeHub:CreateButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSans
	btn.TextScaled = true
	btn.Text = text
	btn.LayoutOrder = #frame:GetChildren()
	btn.Parent = frame
	btn.MouseButton1Click:Connect(callback)
end

-- Toggle creator
function SikeHub:CreateToggle(text, callback)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(1, 0, 0, 30)
	toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggle.Font = Enum.Font.SourceSans
	toggle.TextScaled = true
	toggle.Text = text .. ": OFF"
	toggle.LayoutOrder = #frame:GetChildren()
	toggle.Parent = frame

	local enabled = false
	toggle.MouseButton1Click:Connect(function()
		enabled = not enabled
		toggle.Text = text .. ": " .. (enabled and "ON" or "OFF")
		callback(enabled)
	end)
end

-- Textbox creator
function SikeHub:CreateTextbox(placeholder, callback)
	local textbox = Instance.new("TextBox")
	textbox.Size = UDim2.new(1, 0, 0, 30)
	textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textbox.Font = Enum.Font.SourceSans
	textbox.TextScaled = true
	textbox.PlaceholderText = placeholder
	textbox.Text = ""
	textbox.LayoutOrder = #frame:GetChildren()
	textbox.Parent = frame
	
	textbox.FocusLost:Connect(function(enterPressed)
		if callback then
			callback(textbox.Text, enterPressed)
		end
	end)
	
	return textbox
end

return SikeHub
