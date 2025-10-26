-- ExecutorUI.lua
-- Single-file client UI library for executors / LocalScripts
-- Features: themes, draggable window, tabs, buttons, sliders, dropdowns, textboxes, toggles,
-- hover animations, icons, title, optional local key-gate (copies get-key link to clipboard).
-- Return value: SimpleUI table (call SimpleUI.CreateWindow to make a window)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local SimpleUI = {}
SimpleUI.Themes = {
	Light  = {Background = Color3.fromRGB(245,245,245), Panel = Color3.fromRGB(255,255,255), Accent = Color3.fromRGB(24,144,255), Text = Color3.fromRGB(18,18,18), Subtle = Color3.fromRGB(230,230,230)},
	Dark   = {Background = Color3.fromRGB(28,28,30), Panel = Color3.fromRGB(36,36,38), Accent = Color3.fromRGB(100,169,255), Text = Color3.fromRGB(235,235,240), Subtle = Color3.fromRGB(44,44,46)},
	Neon   = {Background = Color3.fromRGB(6,6,10), Panel = Color3.fromRGB(12,12,18), Accent = Color3.fromRGB(170,170,255), Text = Color3.fromRGB(220,220,255), Subtle = Color3.fromRGB(18,18,26)},
	Ocean  = {Background = Color3.fromRGB(2,18,40), Panel = Color3.fromRGB(6,26,48), Accent = Color3.fromRGB(51,255,255), Text = Color3.fromRGB(215,245,250), Subtle = Color3.fromRGB(8,22,40)},
}

-- Choose parent: PlayerGui -> gethui() -> CoreGui
local function chooseParent()
	local player = Players.LocalPlayer
	if player then
		local ok, pg = pcall(function() return player:WaitForChild("PlayerGui") end)
		if ok and pg then return pg end
	end
	if type(gethui) == "function" then
		local ok, res = pcall(gethui)
		if ok and res and typeof(res) == "Instance" then return res end
	end
	return game:GetService("CoreGui")
end

local function new(class, props)
	local inst = Instance.new(class)
	if props then
		for k,v in pairs(props) do
			inst[k] = v
		end
	end
	return inst
end

local function tween(inst, props, time, style, dir)
	time = time or 0.12
	style = style or Enum.EasingStyle.Quad
	dir = dir or Enum.EasingDirection.Out
	local info = TweenInfo.new(time, style, dir)
	local success, tweenObj = pcall(function() return TweenService:Create(inst, info, props) end)
	if success and tweenObj then
		tweenObj:Play()
		return tweenObj
	end
end

-- default key system validator (local table)
local function defaultKeyValidator(key)
	-- example local keys - replace with your own or provide validator function in options
	local allowed = {
		["tantoswrld123"] = true,
		["demo-key-000"] = true
	}
	return allowed[key] == true
end

-- CreateWindow options:
-- opts = {
--   Title = "My UI",
--   Icon = "rbxassetid://12345" or nil,
--   Theme = "Dark",
--   UseKeyGate = true/false,
--   KeyLink = "https://example.com/getkey",
--   KeyValidator = function(key) return true/false end (optional)
-- }
function SimpleUI.CreateWindow(opts)
	opts = opts or {}
	local titleText = opts.Title or "Simple UI"
	local iconId = opts.Icon -- optional image id
	local startingTheme = opts.Theme and SimpleUI.Themes[opts.Theme] and opts.Theme or "Dark"
	local theme = SimpleUI.Themes[startingTheme]
	local useKeyGate = opts.UseKeyGate == true
	local keyLink = opts.KeyLink or "https://yourhub.example/getkey"
	local keyValidator = opts.KeyValidator or defaultKeyValidator

	local parent = chooseParent()
	local screen = new("ScreenGui", {Name = "SimpleUI_Screen", IgnoreGuiInset = true, ResetOnSpawn = false})
	screen.Parent = parent

	-- root window
	local window = new("Frame", {
		Name = "Window",
		Size = UDim2.new(0, 760, 0, 460),
		Position = UDim2.new(0.5, -380, 0.5, -230),
		AnchorPoint = Vector2.new(0.5,0.5),
		BackgroundColor3 = theme.Panel,
		BorderSizePixel = 0,
		Parent = screen,
	})
	new("UICorner", {Parent = window, CornerRadius = UDim.new(0,12)})
	window.ClipsDescendants = true
	window.Active = true

	-- top bar
	local top = new("Frame", {
		Name = "Top",
		Size = UDim2.new(1,0,0,48),
		Position = UDim2.new(0,0,0,0),
		BackgroundTransparency = 1,
		Parent = window,
	})
	local title = new("TextLabel", {
		Name = "Title",
		Text = titleText,
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = theme.Text,
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 420, 1, 0),
		Position = UDim2.new(0, 12, 0, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = top,
	})
	-- optional icon
	local icon
	if iconId then
		icon = new("ImageLabel", {
			Name = "Icon",
			Size = UDim2.new(0,36,0,36),
			Position = UDim2.new(0, 384, 0.5, -18),
			BackgroundTransparency = 1,
			Image = iconId,
			Parent = top,
		})
		new("UICorner", {Parent = icon, CornerRadius = UDim.new(0,8)})
	end

	-- left column: tabs list
	local leftCol = new("Frame", {
		Name = "Left",
		Size = UDim2.new(0,200,1, -28),
		Position = UDim2.new(0,12,0,56),
		BackgroundColor3 = theme.Panel,
		Parent = window,
	})
	new("UICorner", {Parent = leftCol, CornerRadius = UDim.new(0,10)})
	local leftPadding = new("UIPadding", {Parent = leftCol, PaddingTop = UDim.new(0,12), PaddingLeft = UDim.new(0,10), PaddingRight = UDim.new(0,10)})
	local tabsList = new("ScrollingFrame", {
		Name = "TabsList",
		Size = UDim2.new(1, 0, 1, -80),
		Position = UDim2.new(0,0,0,0),
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
		Parent = leftCol,
	})
	local tabsLayout = new("UIListLayout", {Parent = tabsList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,8)})
	tabsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	tabsList.CanvasSize = UDim2.new(0,0,0,0)
	local function updateCanvasSize()
		tabsList.CanvasSize = UDim2.new(0,0,0, tabsLayout.AbsoluteContentSize.Y + 12)
	end
	tabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

	-- left footer for small info (like key status or user)
	local leftFooter = new("Frame", {Parent = leftCol, Size = UDim2.new(1,0,0,72), Position = UDim2.new(0,0,1,-72), BackgroundTransparency = 1})
	local leftFooterLabel = new("TextLabel", {
		Parent = leftFooter,
		Text = "Welcome",
		BackgroundTransparency = 1,
		Size = UDim2.new(1,0,0,36),
		TextColor3 = theme.Text,
		Font = Enum.Font.SourceSans,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	-- main content area (right panel)
	local rightPanel = new("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -236, 1, -72),
		Position = UDim2.new(0, 224, 0, 56),
		BackgroundColor3 = theme.Panel,
		Parent = window,
	})
	new("UICorner", {Parent = rightPanel, CornerRadius = UDim.new(0,10)})
	rightPanel.ClipsDescendants = true

	-- inside right, content scrolling
	local contentScroll = new("ScrollingFrame", {
		Name = "ContentScroll",
		Parent = rightPanel,
		Size = UDim2.new(1, -24, 1, -24),
		Position = UDim2.new(0,12,0,12),
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
	})
	local contentLayout = new("UIListLayout", {Parent = contentScroll, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,12)})
	contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	contentScroll.CanvasSize = UDim2.new(0,0,0,0)
	contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		contentScroll.CanvasSize = UDim2.new(0,0,0, contentLayout.AbsoluteContentSize.Y + 12)
	end)

	-- store tab objects
	local tabs = {}
	local themeElements = {window, leftCol, rightPanel, top, title, contentScroll, tabsList, leftFooterLabel} -- to apply theme updates

	-- function to apply theme to elements
	-- safer applyTheme: only operate on real Instances & supported classes
local function applytheme(tname)
    if not SimpleUI.Themes[tname] then return end
    local theme = SimpleUI.Themes[tname]

    -- top-level assignments (instances we know exist)
    if window and typeof(window) == "Instance" and window:IsA("GuiObject") then
        window.BackgroundColor3 = theme.Panel
    end
    if title and typeof(title) == "Instance" and title:IsA("TextLabel") then
        title.TextColor3 = theme.Text
    end

    -- iterate stored themeElements table safely
    for _, v in ipairs(themeElements) do
        if typeof(v) == "Instance" then
            -- Frames and ImageLabels get colored by Panel or Background
            if v:IsA("Frame") or v:IsA("ImageLabel") then
                -- keep some frames untouched if you prefer; using Panel as default
                if pcall(function() v.BackgroundColor3 = theme.Panel end) then
                    -- ok
                end
            end

            -- Text elements: TextLabel, TextButton, TextBox
            if v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
                pcall(function() v.TextColor3 = theme.Text end)
                if v:IsA("TextBox") then
                    pcall(function() v.BackgroundColor3 = theme.Background end)
                end
            end

            -- If a button uses accent backgrounds, preserve that by not forcing BackgroundColor3
            -- You can add more granular checks here if needed.
        end
        -- if not an Instance, skip it safely
    end
end


	-- draggable logic (custom)
	do
		local dragging, dragStart, startPos = false, nil, nil
		top.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = window.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = input.Position - dragStart
				window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end

	-- small utility to create section wrappers
	local function createSection(parent, height)
		local frame = new("Frame", {Parent = parent, Size = UDim2.new(1, -24, 0, height), BackgroundTransparency = 1})
		frame.LayoutOrder = #parent:GetChildren() + 1
		return frame
	end

	-- make a tab
	local function createTab(name, icon)
		-- tab button on left
		local tabBtn = new("TextButton", {
			Name = name .. "_Btn",
			Parent = tabsList,
			Size = UDim2.new(1,0,0,40),
			BackgroundColor3 = theme.Background or theme.Panel,
			BorderSizePixel = 0,
			Text = "  "..name,
			TextSize = 16,
			Font = Enum.Font.GothamSemibold,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		new("UICorner", {Parent = tabBtn, CornerRadius = UDim.new(0,8)})
		tabBtn.MouseEnter:Connect(function() tween(tabBtn, {BackgroundColor3 = theme.Subtle}, 0.14) end)
		tabBtn.MouseLeave:Connect(function() tween(tabBtn, {BackgroundColor3 = theme.Background or theme.Panel}, 0.14) end)

		-- page frame on right
		local page = new("Frame", {Parent = contentScroll, Size = UDim2.new(1, -12, 0, 24), BackgroundTransparency = 1})
		page.LayoutOrder = #contentScroll:GetChildren() + 1
		new("UIListLayout", {Parent = page, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,12)})

		-- default activation: hide all pages except first
		local tabObj = {}
		tabObj.Button = tabBtn
		tabObj.Page = page
		tabObj.Name = name

		function tabObj:Activate()
			for _,t in ipairs(tabs) do
				t.Page.Visible = false
				t.Button.BackgroundColor3 = theme.Background or theme.Panel
				t.Button.TextColor3 = theme.Text
			end
			tabBtn.BackgroundColor3 = theme.Accent
			tabBtn.TextColor3 = theme.Panel
			page.Visible = true
		end

		-- create UI components APIs for this tab
		function tabObj:Button(text, callback, opts)
			opts = opts or {}
			local btnFrame = createSection(page, 42)
			local btn = new("TextButton", {
				Parent = btnFrame,
				Text = text,
				Size = UDim2.new(1,0,1,0),
				BackgroundColor3 = opts.BackgroundColor3 or theme.Accent,
				TextColor3 = opts.TextColor3 or theme.Panel,
				Font = Enum.Font.GothamSemibold,
				TextSize = 15,
				BorderSizePixel = 0,
			})
			new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
			btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = btn.BackgroundColor3:lerp(theme.Subtle, 0.12)}, 0.12) end)
			btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = opts.BackgroundColor3 or theme.Accent}, 0.12) end)
			btn.MouseButton1Click:Connect(function()
				tween(btn, {BackgroundTransparency = 0.6}, 0.06)
				task.wait(0.06)
				tween(btn, {BackgroundTransparency = 0}, 0.06)
				if callback then pcall(callback) end
			end)
			return btn
		end

		function tabObj:Toggle(text, default, callback)
			local container = createSection(page, 36)
			local lbl = new("TextLabel", {Parent = container, Text = text, Size = UDim2.new(0.7,0,1,0), BackgroundTransparency = 1, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left})
			local toggleBtn = new("TextButton", {Parent = container, Size = UDim2.new(0.28,0,0.7,0), Position = UDim2.new(0.72,0,0.15,0), BackgroundColor3 = theme.Background, Text = "", BorderSizePixel = 0})
			new("UICorner", {Parent = toggleBtn, CornerRadius = UDim.new(0,10)})
			local inner = new("Frame", {Parent = toggleBtn, Size = UDim2.new(default and 0.5 or 0.02,0,0.8,0), Position = UDim2.new(default and 0.02 or 0.9,0,0.1,0), BackgroundColor3 = default and theme.Accent or Color3.fromRGB(150,150,150)})
			new("UICorner", {Parent = inner, CornerRadius = UDim.new(0,8)})
			toggleBtn.MouseButton1Click:Connect(function()
				default = not default
				if default then
					tween(inner, {Size = UDim2.new(0.5,0,0.8,0), Position = UDim2.new(0.02,0,0.1,0), BackgroundColor3 = theme.Accent}, 0.14)
				else
					tween(inner, {Size = UDim2.new(0.02,0,0.8,0), Position = UDim2.new(0.9,0,0.1,0), BackgroundColor3 = Color3.fromRGB(150,150,150)}, 0.14)
				end
				if callback then pcall(callback, default) end
			end)
			return {Label = lbl, Toggle = toggleBtn}
		end

		function tabObj:Slider(labelText, min, max, default, callback)
			min = min or 0; max = max or 100; default = default or min
			local container = createSection(page, 56)
			local label = new("TextLabel", {Parent = container, Text = labelText .. " : " .. tostring(default), Size = UDim2.new(1,0,0,24), BackgroundTransparency = 1, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left})
			local barBg = new("Frame", {Parent = container, Size = UDim2.new(1,0,0,12), Position = UDim2.new(0,0,0,28), BackgroundColor3 = theme.Background, BorderSizePixel = 0})
			new("UICorner", {Parent = barBg, CornerRadius = UDim.new(0,8)})
			local fill = new("Frame", {Parent = barBg, Size = UDim2.new((default - min)/(max-min),0,1,0), BackgroundColor3 = theme.Accent, BorderSizePixel = 0})
			new("UICorner", {Parent = fill, CornerRadius = UDim.new(0,8)})

			local dragging = false
			local function updateFromPos(x)
				local rel = math.clamp((x - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
				fill.Size = UDim2.new(rel,0,1,0)
				local val = min + (max-min) * rel
				val = math.floor(val*100)/100
				label.Text = labelText .. " : " .. tostring(val)
				if callback then pcall(callback, val) end
			end
			barBg.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					updateFromPos(input.Position.X)
				end
			end)
			barBg.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateFromPos(input.Position.X)
				end
			end)
			return {Label = label, Bar = barBg, Fill = fill}
		end

		function tabObj:Dropdown(labelText, items, defaultIndex, callback)
			items = items or {}
			defaultIndex = defaultIndex or 1
			local container = createSection(page, 36)
			local label = new("TextLabel", {Parent = container, Text = labelText, Size = UDim2.new(0.6,0,1,0), BackgroundTransparency = 1, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left})
			local btn = new("TextButton", {Parent = container, Size = UDim2.new(0.38,0,1,0), Position = UDim2.new(0.62,0,0,0), BackgroundColor3 = theme.Background, Text = tostring(items[defaultIndex] or "None"), TextColor3 = theme.Text, BorderSizePixel = 0})
			new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
			local listFrame = new("Frame", {Parent = container, Size = UDim2.new(1,0,0,0), Position = UDim2.new(0,0,1,6), BackgroundColor3 = theme.Panel, BorderSizePixel = 0, ClipsDescendants = true})
			new("UICorner", {Parent = listFrame, CornerRadius = UDim.new(0,8)})
			local canvas = new("ScrollingFrame", {Parent = listFrame, Size = UDim2.new(1,1,1,0), BackgroundTransparency = 1, ScrollBarThickness = 6})
			local layout = new("UIListLayout", {Parent = canvas, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,6)})
			local function rebuild()
				for _,c in pairs(canvas:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
				for i,v in ipairs(items) do
					local itBtn = new("TextButton", {Parent = canvas, Text = tostring(v), Size = UDim2.new(1,-12,0,28), Position = UDim2.new(0,6,0, (i-1)*32), BackgroundTransparency = 1, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 14, BorderSizePixel = 0})
					itBtn.MouseButton1Click:Connect(function()
						btn.Text = tostring(v)
						tween(listFrame, {Size = UDim2.new(1,0,0,0)}, 0.12)
						if callback then pcall(callback, v, i) end
					end)
				end
				canvas.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 8)
			end
			rebuild()
			local open = false
			btn.MouseButton1Click:Connect(function()
				open = not open
				if open then
					tween(listFrame, {Size = UDim2.new(1,0,0, math.min(#items * 32, 220))}, 0.14)
				else
					tween(listFrame, {Size = UDim2.new(1,0,0, 0)}, 0.14)
				end
			end)
			return {Label = label, Button = btn, Rebuild = rebuild}
		end

		function tabObj:Textbox(labelText, placeholder, callback)
			local container = createSection(page, 36)
			local label = new("TextLabel", {Parent = container, Text = labelText, Size = UDim2.new(0.34,0,1,0), BackgroundTransparency = 1, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left})
			local box = new("TextBox", {Parent = container, Size = UDim2.new(0.64,0,1,0), Position = UDim2.new(0.36,0,0,0), Text = "", PlaceholderText = placeholder or "", BackgroundColor3 = theme.Background, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 14, ClearTextOnFocus = false})
			new("UICorner", {Parent = box, CornerRadius = UDim.new(0,8)})
			box.FocusLost:Connect(function(enter)
				if callback then pcall(callback, box.Text, enter) end
			end)
			return box
		end

		-- default hidden until activated
		page.Visible = false
		table.insert(tabs, tabObj)
		-- auto-activate first tab
		if #tabs == 1 then
			tabObj:Activate()
		end

		tabBtn.MouseButton1Click:Connect(function() tabObj:Activate() end)
		-- store theme elements
		table.insert(themeElements, tabBtn); table.insert(themeElements, page)
		return tabObj
	end

	-- theme selector button near top-right
	local themeBtn = new("TextButton", {Parent = top, Size = UDim2.new(0,140,0,28), Position = UDim2.new(1, -156, 0.5, -14), Text = "Theme: "..startingTheme, BackgroundColor3 = theme.Background or theme.Panel, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 14, BorderSizePixel = 0})
	new("UICorner", {Parent = themeBtn, CornerRadius = UDim.new(0,8)})
	themeBtn.MouseButton1Click:Connect(function()
		-- cycle
		local keys = {}
		for k,_ in pairs(SimpleUI.Themes) do table.insert(keys, k) end
		table.sort(keys)
		local idx = 1
		for i,k in ipairs(keys) do if k == startingTheme then idx = i end end
		idx = idx + 1
		if idx > #keys then idx = 1 end
		startingTheme = keys[idx]
		themeBtn.Text = "Theme: "..startingTheme
		applyTheme(startingTheme)
	end)
	table.insert(themeElements, themeBtn)

	-- key gate overlay (optional)
	local unlocked = not useKeyGate
	local function unlockUI()
		unlocked = true
		leftFooterLabel.Text = "Welcome"
		if keyGateFrame and keyGateFrame.Parent then
			tween(keyGateFrame, {BackgroundTransparency = 1}, 0.18)
			task.delay(0.18, function() if keyGateFrame and keyGateFrame.Parent then keyGateFrame:Destroy() end end)
		end
	end

	local keyGateFrame
	if useKeyGate then
		-- overlay in center of rightPanel to lock interactions until key is validated
		keyGateFrame = new("Frame", {Parent = rightPanel, Size = UDim2.new(1, -12, 1, -12), Position = UDim2.new(0,12,0,12), BackgroundColor3 = theme.Panel, BorderSizePixel = 0})
		new("UICorner", {Parent = keyGateFrame, CornerRadius = UDim.new(0,10)})
		local gateLabel = new("TextLabel", {Parent = keyGateFrame, Text = "This UI is locked. Enter your key to continue.", BackgroundTransparency = 1, Size = UDim2.new(1, -24, 0, 28), Position = UDim2.new(0,12,0,24), TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left})
		local getKeyBtn = new("TextButton", {Parent = keyGateFrame, Text = "Get Key (Copy Link)", Size = UDim2.new(0,220,0,36), Position = UDim2.new(0,12,0,72), BackgroundColor3 = theme.Accent, TextColor3 = theme.Panel, Font = Enum.Font.GothamSemibold, TextSize = 14, BorderSizePixel = 0})
		new("UICorner", {Parent = getKeyBtn, CornerRadius = UDim.new(0,8)})
		local keyBox = new("TextBox", {Parent = keyGateFrame, PlaceholderText = "Paste key here...", Size = UDim2.new(0,320,0,36), Position = UDim2.new(0,12,0,120), BackgroundColor3 = theme.Background, TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 14})
		new("UICorner", {Parent = keyBox, CornerRadius = UDim.new(0,8)})
		local submitBtn = new("TextButton", {Parent = keyGateFrame, Text = "Submit", Size = UDim2.new(0,96,0,36), Position = UDim2.new(0,344,0,120), BackgroundColor3 = theme.Accent, TextColor3 = theme.Panel, Font = Enum.Font.GothamSemibold, TextSize = 14, BorderSizePixel = 0})
		new("UICorner", {Parent = submitBtn, CornerRadius = UDim.new(0,8)})
		local status = new("TextLabel", {Parent = keyGateFrame, Text = "", BackgroundTransparency = 1, Size = UDim2.new(1,-24,0,20), Position = UDim2.new(0,12,0,168), TextColor3 = theme.Text, Font = Enum.Font.SourceSans, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left})

		getKeyBtn.MouseButton1Click:Connect(function()
			-- try setclipboard (common in executors)
			local ok, err = pcall(function()
				if type(setclipboard) == "function" then
					setclipboard(keyLink)
					status.Text = "Copied link to clipboard."
				elseif type(set_clipboard) == "function" then
					set_clipboard(keyLink)
					status.Text = "Copied link to clipboard."
				else
					-- fallback: try to prompt text in status (since we can't copy)
					status.Text = "Copy this link: "..keyLink
				end
			end)
			if not ok then
				status.Text = "Unable to access clipboard. Link: "..keyLink
			end
		end)

		submitBtn.MouseButton1Click:Connect(function()
			local value = keyBox.Text or ""
			if value == "" then
				status.Text = "Please paste a key."
				return
			end
			local success, ok = pcall(function() return keyValidator(value) end)
			if success and ok then
				status.Text = "Key valid. Unlocking..."
				task.delay(0.45, unlockUI)
			else
				status.Text = "Invalid key. Get a key and try again."
			end
		end)

		-- also allow pressing Enter in text box
		keyBox.FocusLost:Connect(function(enter)
			if enter then
				submitBtn:MouseButton1Click()
			end
		end)
		unlocked = false
		leftFooterLabel.Text = "Locked - Key required"
	end

	-- API: AddTab, SetTheme, Destroy
	local api = {}
	function api:AddTab(name, icon)
		local t = createTab(name, icon)
		return t
	end
	function api:SetTheme(name)
		if type(name) ~= "string" or not SimpleUI.Themes[name] then return end
		applyTheme(name)
		themeBtn.Text = "Theme: "..name
	end
	function api:Destroy()
		screen:Destroy()
	end
	-- small convenience to wait until unlocked if caller needs it
	function api:WaitUnlocked(timeout)
		local t0 = tick()
		while not unlocked do
			task.wait(0.06)
			if timeout and tick() - t0 > timeout then return false end
		end
		return true
	end

	-- apply start theme
	applyTheme(startingTheme)

	-- pre-create example tab so users see structure
	local exampleTab = api:AddTab("Main")
	exampleTab:Button("Example Button", function() print("Example clicked") end)
	exampleTab:Slider("Example Slider", 0, 100, 25, function(v) print("Slider", v) end)
	exampleTab:Dropdown("Example Dropdown", {"One","Two","Three"}, 1, function(v,i) print("Picked", v, i) end)
	exampleTab:Textbox("Example Input", "Type here...", function(txt) print("Typed:", txt) end)
	exampleTab:Toggle("Example Toggle", false, function(state) print("Toggled", state) end)

	-- return API
	return api
end

-- Example usage (uncomment to auto-run when script is executed directly)
--[[
local UI = SimpleUI.CreateWindow({
	Title = "Tyrant-Style UI",
	Icon = nil, -- "rbxassetid://1234567890"
	Theme = "Dark",
	UseKeyGate = true,
	KeyLink = "https://yourhub.example/getkey",
	KeyValidator = function(key)
		-- local validation demo: accept "demo-123" or "tantoswrld123"
		return key == "demo-123" or key == "tantoswrld123"
	end
})

local main = UI:AddTab("Catching")
main:Button("Test", function() print("test clicked") end)
main:Slider("Magnet Radius", 0, 100, 25, function(v) print("radius", v) end)
main:Dropdown("Magnet Type", {"Regular","Strong","Ultra"}, 1, function(v) print("type", v) end)
main:Textbox("Custom Key", "Paste key...", function(txt) print("entered:", txt) end)
-- Wait until unlocked before enabling certain actions if needed:
task.spawn(function()
	if UI:WaitUnlocked(120) then
		print("Unlocked! you can proceed.")
	end
end)
]]

return SimpleUI
