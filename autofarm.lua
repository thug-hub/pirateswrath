local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Thug Hub - Pirates Wrath", "DarkTheme")

local Tab = Window:NewTab("Main")

local Section = Tab:NewSection("Autofarm")

local me = game.Players.LocalPlayer

local Plr = game:GetService("Players").LocalPlayer

local selectedmobs = {}

local selecteddropdown = Section:NewDropdown("Selected Mobs", "Mob Select", selectedmobs, function(currentOption)
end)

Section:NewDropdown("Select Mobs", "Mob Select", {"Bandit", "Buggy", "Marine", "Fishman", "Exe", "Siren"}, function(currentOption)
    if not table.find(selectedmobs, currentOption) then
        table.insert(selectedmobs, currentOption)
        selecteddropdown:Refresh(selectedmobs)
    else
        table.remove(selectedmobs, table.find(selectedmobs, currentOption))
        selecteddropdown:Refresh(selectedmobs)
    end
end)

local distance = -6
Section:NewSlider("Mob Distance", "SliderInfo", 10, -10, function(s) -- 500 (MaxValue) | 0 (MinValue)
    distance = s
end)

getgenv().autofarm = nil
Section:NewToggle("Auto Farm", "ToggleInfo", function(state)
    if state then
        getgenv().autofarm = true
    else
        getgenv().autofarm = false
    end
    
    while getgenv().autofarm do
        wait(2)
        
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            for h, j in pairs(selectedmobs) do
                if v.ClassName == "Model" and v:FindFirstChild("HumanoidRootPart") and string.find(v.Name, j) then
                            v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, distance)
                            v.HumanoidRootPart.Anchored = true
                            end
                        end
                    end
    end
end)

getgenv().autoattack = nil
Section:NewToggle("Auto Attack", "ToggleInfo", function(state)
    if state then
        getgenv().autoattack = true
    else
        getgenv().autoattack = false
    end
    
    while getgenv().autoattack do
        wait(0.2)
        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v.ClassName == "Tool" then
                v:Activate()
            end
        end
    end
end)

getgenv().autohaki = nil
Section:NewToggle("Auto Haki", "ToggleInfo", function(state)
    if state then
        getgenv().autohaki = true
    else
        getgenv().autohaki = false
    end
    
    while getgenv().autohaki do
        wait(0.2)
        if not game.Players.LocalPlayer.Character:FindFirstChild("BusoHands") then
            game:GetService("ReplicatedStorage"):WaitForChild("Hakis"):WaitForChild("BusoHaki"):FireServer()
        end
    end
end)

local Tab2 = Window:NewTab("Other")

local Section2 = Tab2:NewSection("Misc")

Section2:NewButton("Claim All Chests", "ButtonInfo", function()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
       if v.ClassName == "MeshPart" and v:FindFirstChild("ClickDetector") then
           v.CFrame =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-4.5)
           fireclickdetector(v.ClickDetector)
       end
    end
end)

Section2:NewButton("TP to Safe Place", "ButtonInfo", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4000, 50000, 8000)
    baseplatee = Instance.new("Part", workspace)
    baseplatee.Size = Vector3.new(1000, 1, 1000)
    baseplatee.CFrame = game.workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.CFrame + Vector3.new(0,-2, 0)
    baseplatee.Anchored = true
end)
