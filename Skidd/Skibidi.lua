--
--
if not getgenv then
    getgenv = function() return _G end
end

getgenv().G2_ENV = {
    Services = {
        Players = game:GetService("Players"),
        UserInputService = game:GetService("UserInputService"),
        TweenService = game:GetService("TweenService"),
        RunService = game:GetService("RunService")
    },
    
    Utils = {
        CreateCorner = function(parent, radius)
            local corner = Instance.new("UICorner", parent)
            corner.CornerRadius = UDim.new(0, radius or 8)
            return corner
        end,
        
        CreateStroke = function(parent, color, thickness)
            local stroke = Instance.new("UIStroke", parent)
            stroke.Color = color or Color3.fromRGB(220, 38, 38) -- Red border by default
            stroke.Thickness = thickness or 2 -- Thicker red border
            return stroke
        end,
        
        Tween = function(object, duration, properties)
            local tweenInfo = TweenInfo.new(
                duration or 0.25, 
                Enum.EasingStyle.Quart, 
                Enum.EasingDirection.Out
            )
            local tween = getgenv().G2_ENV.Services.TweenService:Create(object, tweenInfo, properties)
            tween:Play()
            return tween
        end,
        -- i added A Simple Theme ( Cause I'm noob at Scripting:> )
        Themes = {
            Black = {
                Background = Color3.fromRGB(15, 15, 15),
                Element = Color3.fromRGB(28, 28, 28),
                ElementHover = Color3.fromRGB(38, 38, 38),
                ElementActive = Color3.fromRGB(48, 48, 48),
                Text = Color3.fromRGB(245, 245, 245),
                TextSecondary = Color3.fromRGB(170, 170, 170),
                Border = Color3.fromRGB(220, 38, 38),
                BorderHover = Color3.fromRGB(255, 69, 0),
                Accent = Color3.fromRGB(220, 38, 38),
                AccentHover = Color3.fromRGB(185, 28, 28),
                Success = Color3.fromRGB(34, 197, 94),
                SuccessHover = Color3.fromRGB(22, 163, 74)
            },
            White = {
                Background = Color3.fromRGB(250, 250, 250),
                Element = Color3.fromRGB(235, 235, 235),
                ElementHover = Color3.fromRGB(220, 220, 220),
                ElementActive = Color3.fromRGB(200, 200, 200),
                Text = Color3.fromRGB(20, 20, 20),
                TextSecondary = Color3.fromRGB(100, 100, 100),
                Border = Color3.fromRGB(220, 38, 38),
                BorderHover = Color3.fromRGB(255, 69, 0),
                Accent = Color3.fromRGB(220, 38, 38),
                AccentHover = Color3.fromRGB(185, 28, 28),
                Success = Color3.fromRGB(34, 197, 94),
                SuccessHover = Color3.fromRGB(22, 163, 74)
            }
        },
        
        CurrentTheme = "Black",
        
        Colors = {},
        
        UIElements = {},
        
        SetTheme = function(theme)
            if getgenv().G2_ENV.Utils.Themes[theme] then
                getgenv().G2_ENV.Utils.CurrentTheme = theme
                getgenv().G2_ENV.Utils.Colors = getgenv().G2_ENV.Utils.Themes[theme]
                
                for _, element in pairs(getgenv().G2_ENV.Utils.UIElements) do
                    if element.Type == "Frame" and element.Object and element.Object.Parent then
                        element.Object.BackgroundColor3 = getgenv().G2_ENV.Utils.Colors.Background
                        if element.Object:FindFirstChild("UIStroke") then
                            element.Object.UIStroke.Color = getgenv().G2_ENV.Utils.Colors.Border
                        end
                    elseif element.Type == "Button" and element.Object and element.Object.Parent then
                        element.Object.BackgroundColor3 = getgenv().G2_ENV.Utils.Colors.Element
                        element.Object.TextColor3 = getgenv().G2_ENV.Utils.Colors.Text
                        if element.Object:FindFirstChild("UIStroke") then
                            element.Object.UIStroke.Color = getgenv().G2_ENV.Utils.Colors.Border
                        end
                    elseif element.Type == "Toggle" and element.Object and element.Object.Parent then
                        element.Object.BackgroundColor3 = element.State and getgenv().G2_ENV.Utils.Colors.Success or getgenv().G2_ENV.Utils.Colors.Element
                        element.Object.TextColor3 = getgenv().G2_ENV.Utils.Colors.Text
                        if element.Object:FindFirstChild("UIStroke") then
                            element.Object.UIStroke.Color = getgenv().G2_ENV.Utils.Colors.Border
                        end
                    elseif element.Type == "Textbox" and element.Object and element.Object.Parent then
                        element.Object.BackgroundColor3 = getgenv().G2_ENV.Utils.Colors.Element
                        element.Object.TextColor3 = getgenv().G2_ENV.Utils.Colors.Text
                        element.Object.PlaceholderColor3 = getgenv().G2_ENV.Utils.Colors.TextSecondary
                        if element.Object:FindFirstChild("UIStroke") then
                            element.Object.UIStroke.Color = getgenv().G2_ENV.Utils.Colors.Border
                        end
                    elseif element.Type == "Label" and element.Object and element.Object.Parent then
                        element.Object.TextColor3 = getgenv().G2_ENV.Utils.Colors.Text
                    elseif element.Type == "ScrollBar" and element.Object and element.Object.Parent then
                        element.Object.ScrollBarImageColor3 = getgenv().G2_ENV.Utils.Colors.Accent
                    end
                end
            end
        end
    },
    
    DragController = {
        MakeDraggable = function(frame)
            local dragging = false
            local dragInput, dragStart, startPos
            local uis = getgenv().G2_ENV.Services.UserInputService
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = frame.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)
            
            uis.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                                input.UserInputType == Enum.UserInputType.Touch) then
                    local delta = input.Position - dragStart
                    frame.Position = UDim2.new(
                        startPos.X.Scale, 
                        startPos.X.Offset + delta.X, 
                        startPos.Y.Scale, 
                        startPos.Y.Offset + delta.Y
                    )
                end
            end)
            
            frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
        end
    },
    -- i add Some Animation:> VantaXock helps me :3 4 hours Adding this Cause I'm noob at scripting:3
    Animations = {
        ButtonClick = function(button)
            local colors = getgenv().G2_ENV.Utils.Colors
            getgenv().G2_ENV.Utils.Tween(button, 0.1, {BackgroundColor3 = colors.ElementActive})
            
            if button:FindFirstChild("UIStroke") then
                getgenv().G2_ENV.Utils.Tween(button.UIStroke, 0.1, {
                    Color = Color3.fromRGB(255, 69, 0), -- Bright red
                    Thickness = 3
                })
            end
            task.wait(0.1)
            getgenv().G2_ENV.Utils.Tween(button, 0.15, {BackgroundColor3 = colors.Element})
            if button:FindFirstChild("UIStroke") then
                getgenv().G2_ENV.Utils.Tween(button.UIStroke, 0.15, {
                    Color = colors.Border,
                    Thickness = 2
                })
            end
        end,
        
        ToggleSwitch = function(toggle, state)
            local colors = getgenv().G2_ENV.Utils.Colors
            local newColor = state and colors.Success or colors.Element
            getgenv().G2_ENV.Utils.Tween(toggle, 0.3, {BackgroundColor3 = newColor})
            -- Red border glow for toggle
            if toggle:FindFirstChild("UIStroke") then
                getgenv().G2_ENV.Utils.Tween(toggle.UIStroke, 0.3, {
                    Color = state and Color3.fromRGB(255, 69, 0) or colors.Border,
                    Thickness = state and 3 or 2
                })
            end
        end,
        
        TextboxFocus = function(textbox, focused)
            local colors = getgenv().G2_ENV.Utils.Colors
            local borderColor = focused and Color3.fromRGB(255, 69, 0) or colors.Border -- Bright red when focused
            local bgColor = focused and colors.ElementHover or colors.Element
            local thickness = focused and 3 or 2 -- Thicker when focused
            getgenv().G2_ENV.Utils.Tween(textbox, 0.2, {BackgroundColor3 = bgColor})
            if textbox:FindFirstChild("UIStroke") then
                getgenv().G2_ENV.Utils.Tween(textbox.UIStroke, 0.2, {
                    Color = borderColor,
                    Thickness = thickness
                })
            end
        end
    },
    
    Version = "2.0.0",
    Loaded = true
}

getgenv().G2_ENV.Utils.SetTheme("Black")

local function kickUser(elementType)
    if elementType == "button" then
        game.Players.LocalPlayer:Kick("Check your button logic⚠️")
    elseif elementType == "toggle" then
        game.Players.LocalPlayer:Kick("Check your toggle logic ⚠️")
    elseif elementType == "textbox" then
        game.Players.LocalPlayer:Kick("Check your textbox logic ⚠️")
    end
end

local G2GUI = {}
local env = getgenv().G2_ENV

function G2GUI:CreateWindow(title, maxHeight, theme)
    local window = {}
    maxHeight = maxHeight or 300
    
    if theme and env.Utils.Themes[theme] then
        env.Utils.SetTheme(theme)
    end
    
    local gui = Instance.new("ScreenGui", env.Services.Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "G2GUI_" .. title
    gui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 180, 0, math.min(50, maxHeight))
    frame.Position = UDim2.new(0, 100, 0, 100)
    frame.BackgroundColor3 = env.Utils.Colors.Background
    frame.Active = true
    frame.Draggable = false
    frame.ClipsDescendants = true
    
    env.Utils.CreateCorner(frame, 10)
    env.Utils.CreateStroke(frame, Color3.fromRGB(220, 38, 38), 2) -- Red UI border
    
    table.insert(env.Utils.UIElements, {
        Type = "Frame",
        Object = frame
    })
    
    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, 0, 0, 28)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = env.Utils.Colors.Text
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    
    table.insert(env.Utils.UIElements, {
        Type = "Label",
        Object = titleLabel
    })
    
    local scrollFrame = Instance.new("ScrollingFrame", frame)
    scrollFrame.Size = UDim2.new(1, 0, 1, -28)
    scrollFrame.Position = UDim2.new(0, 0, 0, 28)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 3
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(220, 38, 38) -- Red scrollbar
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    
    table.insert(env.Utils.UIElements, {
        Type = "ScrollBar",
        Object = scrollFrame
    })
    
    local container = Instance.new("Frame", scrollFrame)
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    
    env.DragController.MakeDraggable(frame)
    
    local elementCount = 0
    
    local function updateSize()
        local contentHeight = (elementCount * 45) + 20
        local frameHeight = math.min(28 + contentHeight, maxHeight)
        
        frame.Size = UDim2.new(0, 180, 0, frameHeight)
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
        container.Size = UDim2.new(1, 0, 0, contentHeight)
    end
    
    function window:Button(text, callback)
        
        if type(text) ~= "string" or text == nil then
            kickUser("button")
            return
        end
        
        if callback and type(callback) ~= "function" then
            kickUser("button")
            return
        end
        
        elementCount = elementCount + 1
        
        local button = Instance.new("TextButton", container)
        button.Size = UDim2.new(1, -20, 0, 35)
        button.Position = UDim2.new(0, 10, 0, (elementCount - 1) * 45 + 10)
        button.BackgroundColor3 = env.Utils.Colors.Element
        button.TextColor3 = env.Utils.Colors.Text
        button.Font = Enum.Font.Gotham
        button.TextScaled = true
        button.Text = text
        env.Utils.CreateCorner(button, 6)
        env.Utils.CreateStroke(button, Color3.fromRGB(220, 38, 38), 2) -- Red button border
        
        table.insert(env.Utils.UIElements, {
            Type = "Button",
            Object = button
        })
        
        button.MouseEnter:Connect(function()
            env.Utils.Tween(button, 0.2, {BackgroundColor3 = env.Utils.Colors.ElementHover})
            env.Utils.Tween(button.UIStroke, 0.2, {
                Color = Color3.fromRGB(255, 69, 0), -- Bright red on hover
                Thickness = 3
            })
        end)
        button.MouseLeave:Connect(function()
            env.Utils.Tween(button, 0.2, {BackgroundColor3 = env.Utils.Colors.Element})
            env.Utils.Tween(button.UIStroke, 0.2, {
                Color = Color3.fromRGB(220, 38, 38), -- Back to normal red
                Thickness = 2
            })
        end)
        
        button.MouseButton1Click:Connect(function()
            env.Animations.ButtonClick(button)
            if callback then 
                local success, error = pcall(callback)
                if not success then
                    kickUser("button")
                end
            end
        end)
        
        updateSize()
        return button
    end
    
    function window:Toggle(text, state, callback)
        
        if type(text) ~= "string" or text == nil then
            kickUser("toggle")
            return
        end
        
        if state ~= nil and type(state) ~= "boolean" then
            kickUser("toggle")
            return
        end
        
        if callback and type(callback) ~= "function" then
            kickUser("toggle")
            return
        end
        
        elementCount = elementCount + 1
        state = state or false
        
        local toggle = Instance.new("TextButton", container)
        toggle.Size = UDim2.new(1, -20, 0, 35)
        toggle.Position = UDim2.new(0, 10, 0, (elementCount - 1) * 45 + 10)
        toggle.BackgroundColor3 = state and env.Utils.Colors.Success or env.Utils.Colors.Element
        toggle.TextColor3 = env.Utils.Colors.Text
        toggle.Font = Enum.Font.Gotham
        toggle.TextScaled = true
        toggle.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
        env.Utils.CreateCorner(toggle, 6)
        env.Utils.CreateStroke(toggle, Color3.fromRGB(220, 38, 38), 2) -- Red toggle border
        
        local toggleElement = {
            Type = "Toggle",
            Object = toggle,
            State = state
        }
        table.insert(env.Utils.UIElements, toggleElement)
        
        toggle.MouseEnter:Connect(function()
            local hoverColor = state and env.Utils.Colors.SuccessHover or env.Utils.Colors.ElementHover
            env.Utils.Tween(toggle, 0.2, {BackgroundColor3 = hoverColor})
            env.Utils.Tween(toggle.UIStroke, 0.2, {
                Color = Color3.fromRGB(255, 69, 0), -- Bright red on hover
                Thickness = 3
            })
        end)
        toggle.MouseLeave:Connect(function()
            local normalColor = state and env.Utils.Colors.Success or env.Utils.Colors.Element
            env.Utils.Tween(toggle, 0.2, {BackgroundColor3 = normalColor})
            env.Utils.Tween(toggle.UIStroke, 0.2, {
                Color = Color3.fromRGB(220, 38, 38), -- Back to normal red
                Thickness = state and 3 or 2
            })
        end)
        
        toggle.MouseButton1Click:Connect(function()
            state = not state
            toggleElement.State = state -- Update stored state
            toggle.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
            
            env.Animations.ToggleSwitch(toggle, state)
            
            if callback then 
                local success, error = pcall(callback, state)
                if not success then
                    kickUser("toggle")
                end
            end
        end)
        
        updateSize()
        return toggle
    end
    
    function window:Textbox(text, placeholder, callback)
        
        if type(text) ~= "string" or text == nil then
            kickUser("textbox")
            return
        end
        
        if placeholder and type(placeholder) ~= "string" then
            kickUser("textbox")
            return
        end
        
        if callback and type(callback) ~= "function" then
            kickUser("textbox")
            return
        end
        
        elementCount = elementCount + 1
        placeholder = placeholder or "Enter text..."
        
        local textboxFrame = Instance.new("Frame", container)
        textboxFrame.Size = UDim2.new(1, -20, 0, 35)
        textboxFrame.Position = UDim2.new(0, 10, 0, (elementCount - 1) * 45 + 10)
        textboxFrame.BackgroundTransparency = 1
        
        local textboxLabel = Instance.new("TextLabel", textboxFrame)
        textboxLabel.Size = UDim2.new(0.4, -5, 1, 0)
        textboxLabel.Position = UDim2.new(0, 0, 0, 0)
        textboxLabel.BackgroundTransparency = 1
        textboxLabel.Text = text
        textboxLabel.TextColor3 = env.Utils.Colors.Text
        textboxLabel.TextScaled = true
        textboxLabel.Font = Enum.Font.Gotham
        textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        table.insert(env.Utils.UIElements, {
            Type = "Label",
            Object = textboxLabel
        })
        
        local textbox = Instance.new("TextBox", textboxFrame)
        textbox.Size = UDim2.new(0.6, -5, 1, 0)
        textbox.Position = UDim2.new(0.4, 5, 0, 0)
        textbox.BackgroundColor3 = env.Utils.Colors.Element
        textbox.TextColor3 = env.Utils.Colors.Text
        textbox.PlaceholderColor3 = env.Utils.Colors.TextSecondary
        textbox.Font = Enum.Font.Gotham
        textbox.TextScaled = true
        textbox.Text = ""
        textbox.PlaceholderText = placeholder
        textbox.ClearTextOnFocus = false
        env.Utils.CreateCorner(textbox, 4)
        env.Utils.CreateStroke(textbox, Color3.fromRGB(220, 38, 38), 2) -- Red textbox border
        
        table.insert(env.Utils.UIElements, {
            Type = "Textbox",
            Object = textbox
        })
        
        textbox.Focused:Connect(function()
            env.Animations.TextboxFocus(textbox, true)
        end)
        
        textbox.FocusLost:Connect(function(enterPressed)
            env.Animations.TextboxFocus(textbox, false)
            if callback and enterPressed then
                local success, error = pcall(callback, textbox.Text)
                if not success then
                    kickUser("textbox")
                end
            end
        end)
        
        updateSize()
        return {
            frame = textboxFrame,
            textbox = textbox,
            label = textboxLabel
        }
    end
    
    function window:SetTheme(theme)
        env.Utils.SetTheme(theme)
    end
    
    return window
end

print("[What you looking for Master?]")
print("[Welcome]")
return G2GUI
