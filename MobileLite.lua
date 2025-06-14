-- Interface.lua — основной UI и функции DEDIKSMAIL

local Orion = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Win = Orion:MakeWindow({
    Name = "DEDIKSMAIL",
    Themeable = {
        BackColor = Color3.fromRGB(17,17,17),
        AccentColor = Color3.fromRGB(255,255,255)
    }
})

local settings = { AutoFarm=true, AutoQuest=true, FruitFarm=true, ScamTrade=true }

local tab = Win:MakeTab({ Name = "Функции", Icon = "rbxassetid://6034509993" })

tab:AddToggle({ Name="AutoFarm", Default=true, Callback=function(v) settings.AutoFarm=v end })
tab:AddToggle({ Name="AutoQuest", Default=true, Callback=function(v) settings.AutoQuest=v end })
tab:AddToggle({ Name="FruitFarm", Default=true, Callback=function(v) settings.FruitFarm=v end })
tab:AddToggle({ Name="ScamTrade", Default=true, Callback=function(v) settings.ScamTrade=v end })

spawn(function()
    while task.wait(0.5) do
        local plr = game.Players.LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if settings.AutoFarm and hrp then
            for _,mob in ipairs(workspace:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health>0 then
                    local mhrp=mob:FindFirstChild("HumanoidRootPart")
                    if mhrp then
                        hrp.CFrame=mhrp.CFrame*CFrame.new(0,5,0)
                        task.wait(0.1)
                        pcall(function() game.ReplicatedStorage.Remotes.Combat:FireServer(mob) end)
                        break
                    end
                end
            end
        end
        if settings.AutoQuest then
            pcall(function() game.ReplicatedStorage.Remotes.Quest:InvokeServer("StartQuest","SecondSeaBoss") end)
        end
        if settings.FruitFarm and hrp then
            for _,o in ipairs(workspace:GetDescendants()) do
                if o:IsA("Tool") and o.Name:match("Fruit") then
                    local h=o:FindFirstChild("Handle")
                    if h then
                        hrp.CFrame=h.CFrame
                        task.wait(0.1)
                        firetouchinterest(hrp,h,0)
                        firetouchinterest(hrp,h,1)
                    end
                end
            end
        end
        if settings.ScamTrade then
            local gui = game.CoreGui:FindFirstChild("TradeUI")
            if gui and gui:FindFirstChild("ConfirmButton") then
                local b = gui.ConfirmButton
                b.Text = "⚠️ SCAMMED"
                b.BackgroundColor3 = Color3.fromRGB(100,100,100)
                b.AutoButtonColor = false
            end
        end
    end
end)

Orion:Init()
