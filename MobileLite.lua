-- Приветствие local StarterGui = game:GetService("StarterGui") StarterGui:SetCore("SendNotification", { Title = "📢 Приветствие", Text = "Добро пожаловать DEDIKSMAIL", Duration = 3 })

-- Ждём, чтобы сообщение успело показаться task.wait(3)

-- Интерфейс (чёрно-белый) local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "DEDIKSMAIL_UI" ScreenGui.ResetOnSpawn = false ScreenGui.IgnoreGuiInset = true ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame") MainFrame.Size = UDim2.new(0, 350, 0, 250) MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125) MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) MainFrame.BorderSizePixel = 0 MainFrame.AnchorPoint = Vector2.new(0.5, 0.5) MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner") UICorner.CornerRadius = UDim.new(0, 12) UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel") Title.Size = UDim2.new(1, 0, 0, 40) Title.BackgroundTransparency = 1 Title.Text = "DEDIKSMAIL — Delta X Blox Fruits" Title.Font = Enum.Font.GothamBold Title.TextSize = 16 Title.TextColor3 = Color3.new(1, 1, 1) Title.Parent = MainFrame

-- Основные функции local function AutoFarm() while task.wait(1) do -- Здесь простой пример действия pcall(function() local enemies = workspace.Enemies:GetChildren() for _, enemy in pairs(enemies) do if enemy:FindFirstChild("HumanoidRootPart") then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5) enemy.Humanoid.Health = 0 end end end) end end

local function AutoQuest() -- Пример: автоквест NPC в радиусе for _, npc in pairs(workspace.NPCs:GetChildren()) do if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then local dist = (npc.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude if dist < 20 then fireproximityprompt(npc:FindFirstChildOfClass("ProximityPrompt")) end end end end

-- Кнопка запуска фарма local StartButton = Instance.new("TextButton") StartButton.Size = UDim2.new(0, 150, 0, 40) StartButton.Position = UDim2.new(0.5, -75, 0.5, 20) StartButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60) StartButton.Text = "▶ АвтоФарм" StartButton.TextColor3 = Color3.new(1, 1, 1) StartButton.Font = Enum.Font.GothamBold StartButton.TextSize = 14 StartButton.Parent = MainFrame

local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 8) corner.Parent = StartButton

StartButton.MouseButton1Click:Connect(function() StartButton.Text = "Фарм активен..." task.spawn(AutoFarm) task.spawn(AutoQuest) end)

-- Скам трейд (для стиля) local function ScamTrade() local plr = game.Players.LocalPlayer if plr:FindFirstChild("Backpack") then for _, tool in pairs(plr.Backpack:GetChildren()) do tool.Name = "FreeFruit" -- Переименовываем фрукты в "FreeFruit" end end end

ScamTrade()

-- Перетаскиваемость интерфейса local UIS = game:GetService("UserInputService") local dragging, dragInput, dragStart, startPos MainFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = MainFrame.Position input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end)

UIS.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then local delta = input.Position - dragStart MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

-- Обработка ошибок local success, err = pcall(function() -- основной функционал уже вызван выше end)

if not success then StarterGui:SetCore("SendNotification", { Title = "❌ Ошибка", Text = "Возможна несовместимость с Delta или игрой", Duration = 5 }) end
