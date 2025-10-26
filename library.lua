local Luxt1 = {}

-- Enhanced Theme System with Better Colors
local Themes = {
    Default = {
        Background = Color3.fromRGB(25, 25, 30),
        SecondaryBackground = Color3.fromRGB(35, 35, 42),
        TertiaryBackground = Color3.fromRGB(45, 45, 52),
        QuaternaryBackground = Color3.fromRGB(55, 55, 62),
        Accent = Color3.fromRGB(88, 166, 255),
        SecondaryAccent = Color3.fromRGB(123, 188, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(200, 200, 200),
        TertiaryText = Color3.fromRGB(150, 150, 150),
        WaveColor = Color3.fromRGB(88, 166, 255),
        ButtonHover = Color3.fromRGB(68, 146, 235)
    },
    Dark = {
        Background = Color3.fromRGB(18, 18, 18),
        SecondaryBackground = Color3.fromRGB(28, 28, 28),
        TertiaryBackground = Color3.fromRGB(38, 38, 38),
        QuaternaryBackground = Color3.fromRGB(48, 48, 48),
        Accent = Color3.fromRGB(138, 138, 255),
        SecondaryAccent = Color3.fromRGB(168, 168, 255),
        Text = Color3.fromRGB(240, 240, 240),
        SecondaryText = Color3.fromRGB(180, 180, 180),
        TertiaryText = Color3.fromRGB(120, 120, 120),
        WaveColor = Color3.fromRGB(138, 138, 255),
        ButtonHover = Color3.fromRGB(118, 118, 235)
    },
    Ocean = {
        Background = Color3.fromRGB(15, 30, 45),
        SecondaryBackground = Color3.fromRGB(25, 40, 60),
        TertiaryBackground = Color3.fromRGB(35, 50, 75),
        QuaternaryBackground = Color3.fromRGB(45, 60, 85),
        Accent = Color3.fromRGB(64, 224, 208),
        SecondaryAccent = Color3.fromRGB(94, 244, 228),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(200, 220, 235),
        TertiaryText = Color3.fromRGB(150, 180, 200),
        WaveColor = Color3.fromRGB(64, 224, 208),
        ButtonHover = Color3.fromRGB(44, 204, 188)
    },
    Forest = {
        Background = Color3.fromRGB(20, 35, 25),
        SecondaryBackground = Color3.fromRGB(30, 50, 35),
        TertiaryBackground = Color3.fromRGB(40, 65, 45),
        QuaternaryBackground = Color3.fromRGB(50, 75, 55),
        Accent = Color3.fromRGB(144, 238, 144),
        SecondaryAccent = Color3.fromRGB(174, 255, 174),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(220, 235, 220),
        TertiaryText = Color3.fromRGB(180, 200, 180),
        WaveColor = Color3.fromRGB(144, 238, 144),
        ButtonHover = Color3.fromRGB(124, 218, 124)
    },
    Sunset = {
        Background = Color3.fromRGB(45, 25, 35),
        SecondaryBackground = Color3.fromRGB(60, 35, 50),
        TertiaryBackground = Color3.fromRGB(75, 45, 65),
        QuaternaryBackground = Color3.fromRGB(85, 55, 75),
        Accent = Color3.fromRGB(255, 140, 105),
        SecondaryAccent = Color3.fromRGB(255, 170, 135),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(235, 220, 220),
        TertiaryText = Color3.fromRGB(200, 180, 180),
        WaveColor = Color3.fromRGB(255, 140, 105),
        ButtonHover = Color3.fromRGB(235, 120, 85)
    },
    Purple = {
        Background = Color3.fromRGB(30, 20, 45),
        SecondaryBackground = Color3.fromRGB(45, 30, 65),
        TertiaryBackground = Color3.fromRGB(60, 40, 85),
        QuaternaryBackground = Color3.fromRGB(75, 50, 100),
        Accent = Color3.fromRGB(186, 85, 211),
        SecondaryAccent = Color3.fromRGB(206, 105, 231),
        Text = Color3.fromRGB(255, 255, 255),
        SecondaryText = Color3.fromRGB(235, 220, 235),
        TertiaryText = Color3.fromRGB(200, 180, 200),
        WaveColor = Color3.fromRGB(186, 85, 211),
        ButtonHover = Color3.fromRGB(166, 65, 191)
    }
}

local CurrentTheme = Themes.Default

function Luxt1.SetTheme(themeName)
    if Themes[themeName] then
        CurrentTheme = Themes[themeName]
        return true
    end
    return false
end

function Luxt1.GetAvailableThemes()
    local themeNames = {}
    for name, _ in pairs(Themes) do
        table.insert(themeNames, name)
    end
    return themeNames
end

function Luxt1.CreateWindow(libName, logoId)
    local LuxtLib = Instance.new("ScreenGui")
    local shadow = Instance.new("ImageLabel")
    local MainFrame = Instance.new("Frame")
    local sideHeading = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local sideCover = Instance.new("Frame")
    local hubLogo = Instance.new("ImageLabel")
    local MainCorner_2 = Instance.new("UICorner")
    local hubName = Instance.new("TextLabel")
    local tabFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local usename = Instance.new("TextLabel")
    local MainCorner_3 = Instance.new("UICorner")
    local wave = Instance.new("ImageLabel")
    local MainCorner_4 = Instance.new("UICorner")
    local framesAll = Instance.new("Frame")
    local pageFolder = Instance.new("Folder")

    local key1 = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local keybindInfo1 = Instance.new("TextLabel")

    key1.Name = "key1"
    key1.Parent = sideHeading
    key1.BackgroundColor3 = CurrentTheme.QuaternaryBackground
    key1.Position = UDim2.new(0.0508064516, 0, 0.935261786, 0)
    key1.Size = UDim2.new(0, 85, 0, 28)
    key1.ZIndex = 2
    key1.Font = Enum.Font.GothamSemibold
    key1.Text = "LeftAlt"
    key1.TextColor3 = CurrentTheme.Accent
    key1.TextSize = 16.000

    local oldKey = Enum.KeyCode.LeftAlt.Name

    key1.MouseButton1Click:connect(function(e) 
        key1.Text = ". . ."
        local a, b = game:GetService('UserInputService').InputBegan:wait();
        if a.KeyCode.Name ~= "Unknown" then
            key1.Text = a.KeyCode.Name
            oldKey = a.KeyCode.Name;
        end
    end)

    game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
        if not ok then 
            if current.KeyCode.Name == oldKey then 
                if LuxtLib.Enabled == true then
                    LuxtLib.Enabled = false
                else
                    LuxtLib.Enabled = true
                end
            end
        end
    end)

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = key1

    keybindInfo1.Name = "keybindInfo"
    keybindInfo1.Parent = sideHeading
    keybindInfo1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    keybindInfo1.BackgroundTransparency = 1.000
    keybindInfo1.Position = UDim2.new(0.585064113, 0, 0.935261846, 0)
    keybindInfo1.Size = UDim2.new(0, 60, 0, 28)
    keybindInfo1.ZIndex = 2
    keybindInfo1.Font = Enum.Font.GothamSemibold
    keybindInfo1.Text = "Toggle"
    keybindInfo1.TextColor3 = CurrentTheme.Text
    keybindInfo1.TextSize = 15.000
    keybindInfo1.TextXAlignment = Enum.TextXAlignment.Left

    local UserInputService = game:GetService("UserInputService")
    local TopBar = sideHeading
    local Camera = workspace:WaitForChild("Camera")
    local DragMousePosition
    local FramePosition
    local Draggable = false
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Draggable = true
            DragMousePosition = Vector2.new(input.Position.X, input.Position.Y)
            FramePosition = Vector2.new(shadow.Position.X.Scale, shadow.Position.Y.Scale)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Draggable == true then
            local NewPosition = FramePosition + ((Vector2.new(input.Position.X, input.Position.Y) - DragMousePosition) / Camera.ViewportSize)
            shadow.Position = UDim2.new(NewPosition.X, 0, NewPosition.Y, 0)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Draggable = false
        end
    end)

    pageFolder.Name = "pageFolder"
    pageFolder.Parent = framesAll

    libName = libName or "LuxtLib"
    logoId = logoId or ""

    LuxtLib.Name = "LuxtLib"..libName
    LuxtLib.Parent = game.CoreGui
    LuxtLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = shadow
    MainFrame.BackgroundColor3 = CurrentTheme.Background
    MainFrame.Position = UDim2.new(0.048, 0,0.075, 0)
    MainFrame.Size = UDim2.new(0, 650, 0, 520)

    sideHeading.Name = "sideHeading"
    sideHeading.Parent = MainFrame
    sideHeading.BackgroundColor3 = CurrentTheme.SecondaryBackground
    sideHeading.Size = UDim2.new(0, 180, 0, 520)
    sideHeading.ZIndex = 2

    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = sideHeading

    sideCover.Name = "sideCover"
    sideCover.Parent = sideHeading
    sideCover.BackgroundColor3 = CurrentTheme.SecondaryBackground
    sideCover.BorderSizePixel = 0
    sideCover.Position = UDim2.new(0.909677446, 0, 0, 0)
    sideCover.Size = UDim2.new(0, 16, 0, 520)

    hubLogo.Name = "hubLogo"
    hubLogo.Parent = sideHeading
    hubLogo.BackgroundColor3 = CurrentTheme.Accent
    hubLogo.Position = UDim2.new(0.0567928664, 0, 0.0243411884, 0)
    hubLogo.Size = UDim2.new(0, 36, 0, 36)
    hubLogo.ZIndex = 2
    hubLogo.Image = "rbxassetid://"..logoId

    MainCorner_2.CornerRadius = UDim.new(0, 999)
    MainCorner_2.Name = "MainCorner"
    MainCorner_2.Parent = hubLogo

    hubName.Name = "hubName"
    hubName.Parent = sideHeading
    hubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hubName.BackgroundTransparency = 1.000
    hubName.Position = UDim2.new(0.290000081, 0, 0.0299999975, 0)
    hubName.Size = UDim2.new(0, 120, 0, 20)
    hubName.ZIndex = 2
    hubName.Font = Enum.Font.GothamSemibold
    hubName.Text = libName
    hubName.TextColor3 = CurrentTheme.Accent
    hubName.TextSize = 17.000
    hubName.TextWrapped = true
    hubName.TextXAlignment = Enum.TextXAlignment.Left

    tabFrame.Name = "tabFrame"
    tabFrame.Parent = sideHeading
    tabFrame.Active = true
    tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrame.BackgroundTransparency = 1.000
    tabFrame.BorderSizePixel = 0
    tabFrame.Position = UDim2.new(0.0761478543, 0, 0.126385808, 0)
    tabFrame.Size = UDim2.new(0, 155, 0, 400)
    tabFrame.ZIndex = 2
    tabFrame.ScrollBarThickness = 0

    UIListLayout.Parent = tabFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)

    usename.Name = "usename"
    usename.Parent = sideHeading
    usename.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    usename.BackgroundTransparency = 1.000
    usename.Position = UDim2.new(0.290000081, 0, 0.0700000152, 0)
    usename.Size = UDim2.new(0, 120, 0, 18)
    usename.ZIndex = 2
    usename.Font = Enum.Font.GothamSemibold
    usename.Text = game.Players.LocalPlayer.Name
    usename.TextColor3 = CurrentTheme.SecondaryAccent
    usename.TextSize = 14.000
    usename.TextWrapped = true
    usename.TextXAlignment = Enum.TextXAlignment.Left

    MainCorner_3.CornerRadius = UDim.new(0, 8)
    MainCorner_3.Name = "MainCorner"
    MainCorner_3.Parent = MainFrame

    wave.Name = "wave"
    wave.Parent = MainFrame
    wave.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    wave.BackgroundTransparency = 1.000
    wave.Position = UDim2.new(0.0213434305, 0, 0, 0)
    wave.Size = UDim2.new(0.97865659, 0, 0.557522118, 0)
    wave.Image = "http://www.roblox.com/asset/?id=6087537285"
    wave.ImageColor3 = CurrentTheme.WaveColor
    wave.ImageTransparency = 0.400
    wave.ScaleType = Enum.ScaleType.Slice

    MainCorner_4.CornerRadius = UDim.new(0, 6)
    MainCorner_4.Name = "MainCorner"
    MainCorner_4.Parent = wave

    framesAll.Name = "framesAll"
    framesAll.Parent = MainFrame
    framesAll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    framesAll.BackgroundTransparency = 1.000
    framesAll.BorderSizePixel = 0
    framesAll.Position = UDim2.new(0.296564192, 0, 0.0242873337, 0)
    framesAll.Size = UDim2.new(0, 440, 0, 495)
    framesAll.ZIndex = 2

    shadow.Name = "shadow"
    shadow.Parent = LuxtLib
    shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    shadow.BackgroundTransparency = 1.000
    shadow.Position = UDim2.new(0.25, 0, 0.15, 0)
    shadow.Size = UDim2.new(0, 720, 0, 600)
    shadow.ZIndex = 0
    shadow.Image = "http://www.roblox.com/asset/?id=6105530152"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.300

    local TabHandling = {}

    function TabHandling:Tab(tabText, tabId)
        local tabBtnFrame = Instance.new("Frame")
        local tabBtn = Instance.new("TextButton")
        local tabLogo = Instance.new("ImageLabel")

        tabText = tabText or "Tab"
        tabId = tabId or ""

        tabBtnFrame.Name = "tabBtnFrame"
        tabBtnFrame.Parent = tabFrame
        tabBtnFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabBtnFrame.BackgroundTransparency = 1.000
        tabBtnFrame.Size = UDim2.new(0, 155, 0, 38)
        tabBtnFrame.ZIndex = 2

        tabBtn.Name = "tabBtn"
        tabBtn.Parent = tabBtnFrame
        tabBtn.BackgroundColor3 = Color3.fromRGB(166, 248, 255)
        tabBtn.BackgroundTransparency = 1.000
        tabBtn.Position = UDim2.new(0.245534033, 0, 0, 0)
        tabBtn.Size = UDim2.new(0, 115, 0, 38)
        tabBtn.ZIndex = 2
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.Text = tabText
        tabBtn.TextColor3 = CurrentTheme.Accent
        tabBtn.TextSize = 16.000
        tabBtn.TextXAlignment = Enum.TextXAlignment.Left

        tabLogo.Name = "tabLogo"
        tabLogo.Position = UDim2.new(-0.007, 0,0.067, 0)
        tabLogo.Parent = tabBtnFrame
        tabLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabLogo.BackgroundTransparency = 1.000
        tabLogo.BorderSizePixel = 0
        tabLogo.Size = UDim2.new(0, 30, 0, 30)
        tabLogo.ZIndex = 2
        tabLogo.Image = "rbxassetid://"..tabId
        tabLogo.ImageColor3 = CurrentTheme.Accent

        local newPage = Instance.new("ScrollingFrame")
        local sectionList = Instance.new("UIListLayout")

        newPage.Name = "newPage"..tabText
        newPage.Parent = pageFolder
        newPage.Active = true
        newPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        newPage.BackgroundTransparency = 1.000
        newPage.BorderSizePixel = 0
        newPage.Size = UDim2.new(1, 0, 1, 0)
        newPage.ZIndex = 2
        newPage.ScrollBarThickness = 0
        newPage.Visible = false

        sectionList.Name = "sectionList"
        sectionList.Parent = newPage
        sectionList.SortOrder = Enum.SortOrder.LayoutOrder
        sectionList.Padding = UDim.new(0, 6)

        local function UpdateSize()
            local cS = sectionList.AbsoluteContentSize
            game.TweenService:Create(newPage, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
            }):Play()
        end
        UpdateSize()
        newPage.ChildAdded:Connect(UpdateSize)
        newPage.ChildRemoved:Connect(UpdateSize)

        tabBtn.MouseButton1Click:Connect(function()
            UpdateSize()
            for i,v in next, pageFolder:GetChildren() do
                UpdateSize()
                v.Visible = false
            end
            newPage.Visible = true
            for i,v in next, tabFrame:GetChildren() do
                if v:IsA("Frame") then
                    for i,v in next, v:GetChildren() do
                        if v:IsA("TextButton") then
                            game.TweenService:Create(v, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                                TextColor3 = CurrentTheme.TertiaryText
                            }):Play()
                        end
                        if v:IsA("ImageLabel") then
                            game.TweenService:Create(v, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                                ImageColor3 = CurrentTheme.TertiaryText
                            }):Play()
                        end
                    end
                end
            end
            game.TweenService:Create(tabLogo, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ImageColor3 = CurrentTheme.Accent
            }):Play()
            game.TweenService:Create(tabBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                TextColor3 = CurrentTheme.Accent
            }):Play()
        end)

        local sectionHandling = {}

        function sectionHandling:Section(sectionText)
            local sectionFrame = Instance.new("Frame")
            local MainCorner = Instance.new("UICorner")
            local mainSectionHead = Instance.new("Frame")
            local sectionName = Instance.new("TextLabel")
            local sectionExpannd = Instance.new("ImageButton")
            local sectionInnerList = Instance.new("UIListLayout")

            sectionInnerList.Name = "sectionInnerList"
            sectionInnerList.Parent = sectionFrame
            sectionInnerList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            sectionInnerList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionInnerList.Padding = UDim.new(0, 5)

            sectionText = sectionText or "Section"
            local isDropped = false

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = newPage
            sectionFrame.BackgroundColor3 = CurrentTheme.SecondaryBackground
            sectionFrame.Position = UDim2.new(0, 0, 7.08064434e-08, 0)
            sectionFrame.Size = UDim2.new(1, 0,0, 45)
            sectionFrame.ZIndex = 2
            sectionFrame.ClipsDescendants = true

            MainCorner.CornerRadius = UDim.new(0, 8)
            MainCorner.Name = "MainCorner"
            MainCorner.Parent = sectionFrame

            mainSectionHead.Name = "mainSectionHead"
            mainSectionHead.Parent = sectionFrame
            mainSectionHead.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            mainSectionHead.BackgroundTransparency = 1.000
            mainSectionHead.BorderSizePixel = 0
            mainSectionHead.Size = UDim2.new(0, 440, 0, 45)

            sectionName.Name = "sectionName"
            sectionName.Parent = mainSectionHead
            sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.BackgroundTransparency = 1.000
            sectionName.Position = UDim2.new(0.0236220472, 0, 0, 0)
            sectionName.Size = UDim2.new(0, 350, 0, 45)
            sectionName.Font = Enum.Font.GothamSemibold
            sectionName.Text = sectionText
            sectionName.TextColor3 = CurrentTheme.Accent
            sectionName.TextSize = 17.000
            sectionName.TextXAlignment = Enum.TextXAlignment.Left

            sectionExpannd.Name = "sectionExpannd"
            sectionExpannd.Parent = mainSectionHead
            sectionExpannd.BackgroundTransparency = 1.000
            sectionExpannd.Position = UDim2.new(0.91863519, 0, 0.22, 0)
            sectionExpannd.Size = UDim2.new(0, 28, 0, 28)
            sectionExpannd.ZIndex = 2
            sectionExpannd.Image = "rbxassetid://3926305904"
            sectionExpannd.ImageColor3 = CurrentTheme.Accent
            sectionExpannd.ImageRectOffset = Vector2.new(564, 284)
            sectionExpannd.ImageRectSize = Vector2.new(36, 36)
            
            sectionExpannd.MouseButton1Click:Connect(function()
                if isDropped then
                    isDropped = false
                    sectionFrame:TweenSize(UDim2.new(1, 0,0, 45), "In", "Quint", 0.15)
                    game.TweenService:Create(sectionExpannd, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),{
                        Rotation = 0
                    }):Play()
                    wait(0.15)
                    UpdateSize()
                else
                    isDropped = true
                    sectionFrame:TweenSize(UDim2.new(1,0, 0, sectionInnerList.AbsoluteContentSize.Y + 8), "In", "Quint", 0.15)
                    game.TweenService:Create(sectionExpannd, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),{
                        Rotation = 180
                    }):Play()
                    wait(0.15)
                    UpdateSize()
                end
            end)

            local ItemHandling = {}

            function ItemHandling:Button(btnText, callback)
                local ButtonFrame = Instance.new("Frame")
                local TextButton = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")

                btnText = btnText or "Button"
                callback = callback or function() end

                ButtonFrame.Name = "ButtonFrame"
                ButtonFrame.Parent = sectionFrame
                ButtonFrame.BackgroundColor3 = CurrentTheme.TertiaryBackground
                ButtonFrame.BackgroundTransparency = 1.000
                ButtonFrame.Size = UDim2.new(0, 420, 0, 45)

                TextButton.Parent = ButtonFrame
                TextButton.BackgroundColor3 = CurrentTheme.TertiaryBackground
                TextButton.Size = UDim2.new(0, 420, 0, 45)
                TextButton.ZIndex = 2
                TextButton.AutoButtonColor = false
                TextButton.Text = btnText
                TextButton.Font = Enum.Font.GothamSemibold
                TextButton.TextColor3 = CurrentTheme.SecondaryText
                TextButton.TextSize = 16.000

                local debounce = false
                TextButton.MouseButton1Click:Connect(function()
                    if not debounce then
                        debounce = true
                        callback()
                        wait(1)
                        debounce = false
                    end
                end)

                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = TextButton

                UIListLayout.Parent = ButtonFrame
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                TextButton.MouseEnter:Connect(function()
                    game.TweenService:Create(TextButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{
                        BackgroundColor3 = CurrentTheme.ButtonHover,
                        TextColor3 = CurrentTheme.Text
                    }):Play()
                end)
                
                TextButton.MouseLeave:Connect(function()
                    game.TweenService:Create(TextButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{
                        BackgroundColor3 = CurrentTheme.TertiaryBackground,
                        TextColor3 = CurrentTheme.SecondaryText
                    }):Play()
                end)
            end

            function ItemHandling:Toggle(toggInfo, callback)
                local ToggleFrame = Instance.new("Frame")
                local toggleFrame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local checkBtn = Instance.new("ImageButton")
                local toggleInfo = Instance.new("TextLabel")
                local UIListLayout = Instance.new("UIListLayout")

                toggInfo = toggInfo or "Toggle"
                callback = callback or function() end

                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = sectionFrame
                ToggleFrame.BackgroundColor3 = CurrentTheme.TertiaryBackground
                ToggleFrame.BackgroundTransparency = 1.000
                ToggleFrame.Size = UDim2.new(0, 420, 0, 45)

                toggleFrame.Name = "toggleFrame"
                toggleFrame.Parent = ToggleFrame
                toggleFrame.BackgroundColor3 = CurrentTheme.TertiaryBackground
                toggleFrame.Size = UDim2.new(0, 420, 0, 45)
                toggleFrame.ZIndex = 2

                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = toggleFrame

                checkBtn.Name = "checkBtn"
                checkBtn.Parent = toggleFrame
                checkBtn.BackgroundTransparency = 1.000
                checkBtn.Position = UDim2.new(0.025, 0, 0.22, 0)
                checkBtn.Size = UDim2.new(0, 28, 0, 28)
                checkBtn.ZIndex = 2
                checkBtn.Image = "rbxassetid://3926311105"
                checkBtn.ImageColor3 = CurrentTheme.TertiaryText
                checkBtn.ImageRectOffset = Vector2.new(940, 784)
                checkBtn.ImageRectSize = Vector2.new(48, 48)

                toggleInfo.Name = "toggleInfo"
                toggleInfo.Parent = toggleFrame
                toggleInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleInfo.BackgroundTransparency = 1.000
                toggleInfo.Position = UDim2.new(0.12, 0, 0, 0)
                toggleInfo.Size = UDim2.new(0.8, 0, 1, 0)
                toggleInfo.ZIndex = 2
                toggleInfo.Font = Enum.Font.GothamSemibold
                toggleInfo.Text = toggInfo
                toggleInfo.TextColor3 = CurrentTheme.TertiaryText
                toggleInfo.TextSize = 16.000
                toggleInfo.TextXAlignment = Enum.TextXAlignment.Left

                UIListLayout.Parent = ToggleFrame
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                local on = false
                checkBtn.MouseButton1Click:Connect(function()
                    on = not on
                    callback(on) 
                    if on then
                        toggleInfo.TextColor3 = CurrentTheme.Accent
                        checkBtn.ImageColor3 = CurrentTheme.Accent
                        checkBtn.ImageRectOffset = Vector2.new(4, 836)
                        checkBtn.ImageRectSize = Vector2.new(48,48)
                    else
                        toggleInfo.TextColor3 = CurrentTheme.TertiaryText
                        checkBtn.ImageColor3 = CurrentTheme.TertiaryText
                        checkBtn.ImageRectOffset = Vector2.new(940, 784)
                        checkBtn.ImageRectSize = Vector2.new(48,48)
                    end
                end)
            end

            function ItemHandling:Label(labelInfo)
                local TextLabelFrame = Instance.new("Frame")
                local UIListLayout = Instance.new("UIListLayout")
                local TextLabel = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")
                labelInfo = labelInfo or "Label"

                TextLabelFrame.Name = "TextLabelFrame"
                TextLabelFrame.Parent = sectionFrame
                TextLabelFrame.BackgroundColor3 = CurrentTheme.TertiaryBackground
                TextLabelFrame.BackgroundTransparency = 1.000
                TextLabelFrame.Size = UDim2.new(0, 420, 0, 45)

                UIListLayout.Parent = TextLabelFrame
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                TextLabel.Parent = TextLabelFrame
                TextLabel.BackgroundColor3 = CurrentTheme.TertiaryBackground
                TextLabel.Size = UDim2.new(0, 420, 0, 45)
                TextLabel.ZIndex = 2
                TextLabel.Font = Enum.Font.GothamSemibold
                TextLabel.Text = labelInfo
                TextLabel.TextColor3 = CurrentTheme.Text
                TextLabel.TextSize = 16.000

                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = TextLabel
            end
                        
            return ItemHandling
        end
        return sectionHandling
    end
    return TabHandling
end

return Luxt1
