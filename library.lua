local Library = {}

Library.Theme = {
    Light = {Background = Color3.fromRGB(24, 24, 24), TextColor = Color3.fromRGB(255, 255, 255)},
    Dark = {Background = Color3.fromRGB(44, 44, 44), TextColor = Color3.fromRGB(255, 255, 255)},
    Neon = {Background = Color3.fromRGB(0, 0, 0), TextColor = Color3.fromRGB(170, 170, 255)},
    Ocean = {Background = Color3.fromRGB(0, 0, 51), TextColor = Color3.fromRGB(51, 255, 255)}
}

Library.Create = function(theme)
    local UI = {}
    local Mouse = game.Players.LocalPlayer:GetMouse()

    UI.SetTheme = function(theme)
        UI.Theme = Library.Theme[theme or "Light"]
    end

    UI.SetTheme(theme or "Light")

    UI.DrawRectangle = function(X, Y, Width, Height)
        local Rect = Instance.new("Frame", UI)
        Rect.Size = UDim.new(0, Width) * 2, UDim.new(0, Height)
        Rect.BackgroundColor3 = UI.Theme.Background
        Rect.Position = UDim.new(0, X), UDim.new(0, Y)
        return Rect
    end

    UI.DrawText = function(Text, X, Y, FontSize, FontFace)
        local TextLabel = Instance.new("TextLabel", UI)
        TextLabel.Text = Text
        TextLabel.TextColor3 = UI.Theme.TextColor
        TextLabel.Size = UDim.new(1, 0), UDim.new(0, FontSize)
        TextLabel.FontSize = FontSize
        TextLabel.FontFace = FontFace
        TextLabel.Position = UDim.new(0, X), UDim.new(0, Y)
        return TextLabel
    end

    UI.DrawLabel = function(Text, X, Y)
        return UI.DrawText(Text, X, Y, 18, Enum.Font.SourceSansSemibold)
    end

    UI.DrawTextButton = function(Text, X, Y, OnClick)
        local Button = Instance.new("TextButton", UI)
        Button.Text = Text
        Button.TextColor3 = Color3.fromRGB(0, 0, 0)
        Button.TextSize = 18
        Button.Size = UDim.new(1, 0), UDim.new(0, 25)
        Button.Position = UDim.new(0, X), UDim.new(0, Y)
        Button.BackgroundTransparency = 1
        Button.Active = true
        Button.Selectable = true
        Button.Visible = true

        Button.MouseButton1Click:Connect(function()
            OnClick()
        end)

        return Button
    end

    UI.Input = function(TxtBox, X, Y)
        local Input = Instance.new("TextBox", UI)
        Input.Size = UDim.new(1, 0), UDim.new(0, 25)
        Input.Position = UDim.new(0, X), UDim.new(0, Y)
        Input.TextColor3 = Color3.fromRGB(0, 0, 0)
        Input.Font = Enum.Font.SourceSansSemibold
        Input.FontSize = "Medium"
        Input.TextSize = 18
        Input.TextWrapped = true
        Input.TextXAlignment = Enum.TextXAlignment.Left
        Input.BackgroundTransparency = 1
        Input.MultiLine = false
        Input.ScrollBarThickness = 0
        Input.WordWrap = false
        Input crenlLimit = 70
        Input.ClearTextOnSubmit = false
        Input beigeertasks = false
        return Input
    end

    return UI
end

return Library
