local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EggFarmUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local shadowFrame = Instance.new("Frame")
shadowFrame.Size = UDim2.new(1, 6, 1, 6)
shadowFrame.Position = UDim2.new(0, -3, 0, -3)
shadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadowFrame.BackgroundTransparency = 0.8
shadowFrame.ZIndex = mainFrame.ZIndex - 1
shadowFrame.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 18)
shadowCorner.Parent = shadowFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🐰 Easter Egg Farm 🥚"
titleLabel.TextColor3 = Color3.fromRGB(139, 69, 19)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 45)
statusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.BackgroundTransparency = 0.3
statusLabel.Text = "Status: OFF 💤"
statusLabel.TextColor3 = Color3.fromRGB(139, 69, 19)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusLabel

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 85)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
toggleButton.Text = "START 🚀"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = toggleButton

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 99, 71)
closeButton.Text = "✖"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeButton

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 60, 0, 60)
openButton.Position = UDim2.new(0, 20, 0, 20)
openButton.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
openButton.Text = "🥚"
openButton.TextScaled = true
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 30)
openCorner.Parent = openButton

local run = false
local isUIVisible = true
local particles = {}
local eggIcons = {"🥚", "🐣", "🐤", "🐰", "🌸", "🌷", "🌺", "✨", "🎀", "💖"}
local rainbowFrame = nil
local dragging = false
local dragStart = nil
local startPos = nil

local function makeDraggable(frame)
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
    
    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function createFloatingParticles()
    for i = 1, 8 do
        local particle = Instance.new("TextLabel")
        particle.Size = UDim2.new(0, 20, 0, 20)
        particle.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        particle.BackgroundTransparency = 1
        particle.Text = eggIcons[math.random(1, #eggIcons)]
        particle.TextScaled = true
        particle.TextTransparency = 0.3
        particle.ZIndex = mainFrame.ZIndex - 2
        particle.Parent = screenGui
        
        table.insert(particles, particle)
        
        local function animateParticle()
            while particle.Parent do
                local newX = math.random(0, 100) / 100
                local newY = math.random(0, 100) / 100
                local tween = TweenService:Create(particle, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Sine), {
                    Position = UDim2.new(newX, 0, newY, 0),
                    Rotation = math.random(-30, 30),
                    TextTransparency = math.random(20, 70) / 100
                })
                tween:Play()
                wait(math.random(3, 6))
            end
        end
        
        spawn(animateParticle)
    end
end

local function createEggRainEffect()
    for i = 1, 5 do
        local eggRain = Instance.new("TextLabel")
        eggRain.Size = UDim2.new(0, 15, 0, 15)
        eggRain.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.1, 0)
        eggRain.BackgroundTransparency = 1
        eggRain.Text = "🥚"
        eggRain.TextScaled = true
        eggRain.ZIndex = mainFrame.ZIndex + 5
        eggRain.Parent = screenGui
        
        local fallTween = TweenService:Create(eggRain, TweenInfo.new(math.random(2, 4), Enum.EasingStyle.Linear), {
            Position = UDim2.new(eggRain.Position.X.Scale, 0, 1.1, 0),
            Rotation = math.random(0, 360)
        })
        
        fallTween:Play()
        fallTween.Completed:Connect(function()
            eggRain:Destroy()
        end)
    end
end

local function createBunnyHopEffect()
    local bunny = Instance.new("TextLabel")
    bunny.Size = UDim2.new(0, 30, 0, 30)
    bunny.Position = UDim2.new(-0.1, 0, 0.8, 0)
    bunny.BackgroundTransparency = 1
    bunny.Text = "🐰"
    bunny.TextScaled = true
    bunny.ZIndex = mainFrame.ZIndex + 3
    bunny.Parent = screenGui
    
    local hopTween = TweenService:Create(bunny, TweenInfo.new(3, Enum.EasingStyle.Bounce), {
        Position = UDim2.new(1.1, 0, 0.8, 0)
    })
    
    hopTween:Play()
    hopTween.Completed:Connect(function()
        bunny:Destroy()
    end)
    
    spawn(function()
        for i = 1, 6 do
            wait(0.5)
            local heart = Instance.new("TextLabel")
            heart.Size = UDim2.new(0, 15, 0, 15)
            heart.Position = UDim2.new(bunny.Position.X.Scale, 0, bunny.Position.Y.Scale - 0.1, 0)
            heart.BackgroundTransparency = 1
            heart.Text = "💕"
            heart.TextScaled = true
            heart.ZIndex = mainFrame.ZIndex + 4
            heart.Parent = screenGui
            
            local heartTween = TweenService:Create(heart, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Position = UDim2.new(heart.Position.X.Scale, 0, heart.Position.Y.Scale - 0.15, 0),
                TextTransparency = 1
            })
            
            heartTween:Play()
            heartTween.Completed:Connect(function()
                heart:Destroy()
            end)
        end
    end)
end

local function createSparkleEffect(parent)
    for i = 1, 5 do
        local sparkle = Instance.new("TextLabel")
        sparkle.Size = UDim2.new(0, 12, 0, 12)
        sparkle.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        sparkle.BackgroundTransparency = 1
        sparkle.Text = "✨"
        sparkle.TextScaled = true
        sparkle.ZIndex = parent.ZIndex + 2
        sparkle.Parent = parent
        
        local sparkleTween = TweenService:Create(sparkle, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            TextTransparency = 1,
            Rotation = 360
        })
        
        sparkleTween:Play()
        sparkleTween.Completed:Connect(function()
            sparkle:Destroy()
        end)
    end
end

local function pulseEffect(element)
    local pulseTween = TweenService:Create(element, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        TextTransparency = 0.3
    })
    pulseTween:Play()
    return pulseTween
end

local function animateButton(button)
    local originalSize = button.Size
    local smallerSize = UDim2.new(originalSize.X.Scale * 0.9, originalSize.X.Offset * 0.9, originalSize.Y.Scale * 0.9, originalSize.Y.Offset * 0.9)
    local tween = TweenService:Create(button, TweenInfo.new(0.1), {Size = smallerSize})
    tween:Play()
    tween.Completed:Connect(function()
        local tweenBack = TweenService:Create(button, TweenInfo.new(0.1), {Size = originalSize})
        tweenBack:Play()
    end)
end

local function createRainbowEffect()
    if rainbowFrame then
        rainbowFrame:Destroy()
    end
    
    rainbowFrame = Instance.new("Frame")
    rainbowFrame.Size = UDim2.new(1, 4, 1, 4)
    rainbowFrame.Position = UDim2.new(0, -2, 0, -2)
    rainbowFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    rainbowFrame.ZIndex = mainFrame.ZIndex - 1
    rainbowFrame.Parent = mainFrame
    
    local rainbowCorner = Instance.new("UICorner")
    rainbowCorner.CornerRadius = UDim.new(0, 17)
    rainbowCorner.Parent = rainbowFrame
    
    spawn(function()
        local hue = 0
        while run and rainbowFrame and rainbowFrame.Parent do
            hue = (hue + 0.01) % 1
            rainbowFrame.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            wait(0.05)
        end
        if rainbowFrame and rainbowFrame.Parent then
            rainbowFrame:Destroy()
            rainbowFrame = nil
        end
    end)
    
    return rainbowFrame
end

local function updateStatus()
    if run then
        statusLabel.Text = "Status: ON 🔥"
        statusLabel.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
        toggleButton.Text = "STOP ⏹"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
        createRainbowEffect()
        createSparkleEffect(mainFrame)
        pulseEffect(titleLabel)
    else
        statusLabel.Text = "Status: OFF 💤"
        statusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.Text = "START 🚀"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
        if rainbowFrame then
            rainbowFrame:Destroy()
            rainbowFrame = nil
        end
    end
end

local function toggleUI()
    isUIVisible = not isUIVisible
    mainFrame.Visible = isUIVisible
    openButton.Visible = not isUIVisible
    
    if isUIVisible then
        mainFrame.Position = UDim2.new(0, -300, 0, 20)
        mainFrame.Visible = true
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(0, 20, 0, 20)})
        tween:Play()
    else
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(0, -300, 0, 20)})
        tween:Play()
        tween.Completed:Connect(function()
            mainFrame.Visible = false
        end)
    end
end

makeDraggable(mainFrame)
makeDraggable(openButton)

toggleButton.MouseButton1Click:Connect(function()
    animateButton(toggleButton)
    run = not run
    updateStatus()
    createSparkleEffect(toggleButton)
    if run then
        createBunnyHopEffect()
    end
    print("🥚 Egg farm is now: " .. (run and "ON" or "OFF"))
end)

closeButton.MouseButton1Click:Connect(function()
    animateButton(closeButton)
    createSparkleEffect(closeButton)
    wait(0.1)
    toggleUI()
end)

openButton.MouseButton1Click:Connect(function()
    animateButton(openButton)
    createSparkleEffect(openButton)
    wait(0.1)
    toggleUI()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
        run = not run
        updateStatus()
        createSparkleEffect(mainFrame)
        if run then
            createBunnyHopEffect()
        end
        print("🥚 Egg farm is now: " .. (run and "ON" or "OFF"))
    end
end)

spawn(function()
    while true do
        if run then
            for _, obj in pairs(workspace.EggDropLocations:GetDescendants()) do
                if obj.Name == "EggDropLocation" and obj:IsA("BasePart") then
                    player.Character:PivotTo(obj.CFrame)
                    wait(0.05)
                end
            end
        end
        wait(0.1)
    end
end)

spawn(function()
    while true do
        if isUIVisible then
            local tween = TweenService:Create(mainFrame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(0, 20, 0, 25)})
            tween:Play()
            wait(2)
        else
            wait(0.5)
        end
    end
end)

spawn(function()
    while true do
        if not isUIVisible then
            local tween = TweenService:Create(openButton, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Rotation = 10})
            tween:Play()
            wait(1.5)
        else
            wait(0.5)
        end
    end
end)

spawn(function()
    createFloatingParticles()
    while true do
        wait(math.random(8, 15))
        createEggRainEffect()
    end
end)

spawn(function()
    while true do
        if run then
            wait(math.random(3, 7))
            createEggRainEffect()
        else
            wait(1)
        end
    end
end)

print("🐰 Easter Egg Farm UI Loaded! Press 'E' to toggle or use the cute UI! 🥚")
