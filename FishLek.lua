-------------------------------------------
----- =======[ Load WindUI ]
-------------------------------------------

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-------------------------------------------
----- =======[ GLOBAL FUNCTION ]
-------------------------------------------

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local net = ReplicatedStorage:WaitForChild("Packages")
	:WaitForChild("_Index")
	:WaitForChild("sleitnick_net@0.2.0")
	:WaitForChild("net")

local rodRemote = net:WaitForChild("RF/ChargeFishingRod")
local miniGameRemote = net:WaitForChild("RF/RequestFishingMinigameStarted")
local finishRemote = net:WaitForChild("RE/FishingCompleted")

local Player = Players.LocalPlayer
local XPBar = Player:WaitForChild("PlayerGui"):WaitForChild("XP")

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

task.spawn(function()
    if XPBar then
        XPBar.Enabled = true
    end
end)

local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId

local function AutoReconnect()
    while task.wait(5) do
        if not Players.LocalPlayer or not Players.LocalPlayer:IsDescendantOf(game) then
            TeleportService:Teleport(PlaceId)
        end
    end
end

Players.LocalPlayer.OnTeleport:Connect(function(state)
    if state == Enum.TeleportState.Failed then
        TeleportService:Teleport(PlaceId)
    end
end)

task.spawn(AutoReconnect)

local ijump = false

local RodIdle = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("FishingRodReelIdle")

local RodReel = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("EasyFishReelStart")

local RodShake = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("CastFromFullChargePosition1Hand")

-- Pastikan kamu punya Humanoid
local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Buat Animator jika belum ada
local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

-- Load dan Play animasi
local RodShake = animator:LoadAnimation(RodShake)
local RodIdle = animator:LoadAnimation(RodIdle)
local RodReel = animator:LoadAnimation(RodReel)

-------------------------------------------
----- =======[ NOTIFY FUNCTION ]
-------------------------------------------

local function NotifySuccess(title, message, duration)
    WindUI:Notify({
        Title = title,
        Content = message,
        Duration = duration,
        Icon = "circle-check"
    })
end

local function NotifyError(title, message, duration)
    WindUI:Notify({
        Title = title,
        Content = message,
        Duration = duration,
        Icon = "ban"
    })
end

local function NotifyInfo(title, message, duration)
    WindUI:Notify({
        Title = title,
        Content = message,
        Duration = duration,
        Icon = "info"
    })
end

local function NotifyWarning(title, message, duration)
    WindUI:Notify({
        Title = title,
        Content = message,
        Duration = duration,
        Icon = "triangle-alert"
    })
end

-------------------------------------------
----- =======[ CONFIRM POPUP ]
-------------------------------------------

local confirmed = false
WindUI:Popup({
    Title = "Thanksgiving!",
    Icon = "rbxassetid://129260712070622",
    Content = [[
Thank you for using Premium script!.
]],
    Buttons = {
        { Title = "Close", Variant = "Secondary", Callback = function() end },
        { Title = "Next", Variant = "Primary", Callback = function() confirmed = true end },
    }
})

repeat task.wait() until confirmed


-------------------------------------------
----- =======[ LOAD WINDOW ]
-------------------------------------------

local Window = WindUI:CreateWindow({
    Title = "QuietXHub Premium",
    Icon = "cannabis",
    Author = "by Prince",
    Folder = "QuietXHub",
    Size = UDim2.fromOffset(600, 400),
    Transparent = true,
    Theme = "Dark",
    KeySystem = false,
    ScrollBarEnabled = true,
    HideSearchBar = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
        end,
    }
})

Window:EditOpenButton({
    Title = "QuietXHub",
    Icon = "cannabis",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("9600FF"), 
        Color3.fromHex("AEBAF8")
    ),
    --Enabled = false,
    Draggable = true,
})

local ConfigManager = Window.ConfigManager
local myConfig = ConfigManager:CreateConfig("QuietXConfig")

WindUI:SetNotificationLower(true)

-------------------------------------------
----- =======[ ALL TAB ]
-------------------------------------------


local DevTab = Window:Tab({
    Title = "READ FIRST!",
    Icon = "airplay"
})

local AutoFish = Window:Tab({ 
	Title = "Auto Fish", 
	Icon = "fish"
})

local AutoFarmTab = Window:Tab({
	Title = "Auto Farm",
	Icon = "leaf"
})

local WeatherTab = Window:Tab({
	Title = "Auto Weather", 
	Icon = "cloud-rain"
	
})

local Utils = Window:Tab({
    Title = "Utility",
    Icon = "earth"
})

local SettingsTab = Window:Tab({ 
	Title = "Settings", 
	Icon = "cog" 
})

-------------------------------------------
----- =======[ DEVELOPER TAB ]
-------------------------------------------

DevTab:Paragraph({
    Title = "Developer",
    Desc = "This is Developer Contact",
    Color = "Green",
    Buttons = {
    	{
    		Title = "Discord Server",
    		Callback = function()
    			setclipboard("https://discord.gg/2aMDrb92kf")
    		end
    	},
      {
      	Title = "Instagram",
      	Callback = function()
      		setclipboard("https://instagram.com/quietxdev")
        end
      },
      {
      	Title = "Github",
      	Callback = function()
      		setclipboard("https://github.com/ohmygod-king")
        end
      }
    }
})

DevTab:Paragraph({
	Title = "Feature Guide",
	Color = "Grey",
	Desc = [[
====| Auto Enchant Rod |====

For the Enchant Rod feature, please read this first.
Before enchanting, you are required to have an Enchant Stone, then put the Enchant Stones in the 5th slot, then wait until the Enchant is successful. The Enchant Rod feature can be used anywhere.

========================•=========================

====| Rod Modifier |====

For the Rod Modifier feature, you can only change each rod once. If you want to change another rod, then the previous rod will be reset.

And for this feature, it says it can only increase 1.5x from your default rod stats.

Please reset Character after using to work perfectly

========================•=========================

====| Auto Farm |====

Before using it, I will teach you how to set up Auto Farm.

Please select the island you want to visit.Please select the island you want to farm.

Available Island Codes:
01 = Crater Islands
02 = Tropical Grove
03 = Vulcano
04 = Coral Reefs
05 = Winter Fest
06 = Weather Machine
07 = Treasure Room
08 = Deap Sea

Auto Farm Event (Opsional) :
Enable this if you want to farm during events as well, and leave it on if you don't need it!

Fish Threshold :
What is "Fish Threshold"? Detects the number of fish you have caught, if it has reached the number you have determined, it will sell all the fish that have been caught, except above legendary.

========================•=========================
]]
})

-------------------------------------------
----- =======[ AUTO FISH TAB ]
-------------------------------------------


-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remote
local REReplicateTextEffect = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/ReplicateTextEffect"]

-- Vars
local autofish = false
local perfectCast = true
local customDelay = 1
local fishingActive = false
local delayInitialized = false


local slowRods = {
["Astral Rod"] = true,
["Chrome Rod"] = true,
["Steampunk Rod"] = true,
["Lucky Rod"] = true,
["Midnight Rod"] = true,
["Demascus Rod"] = true,
["Grass Rod"] = true,
["Luck Rod"] = true,
["Carbon Rod"] = true,
["Lava Rod"] = true,
["Starter Rod"] = true
}
local fastRods = {
["Ares Rod"] = true,
["Angler Rod"] = true,
["Ghostfinn Rod"] = true
}

local function getValidRodName()
local player = Players.LocalPlayer
local display = player.PlayerGui:WaitForChild("Backpack"):WaitForChild("Display")

for _, tile in ipairs(display:GetChildren()) do      
    local success, itemNamePath = pcall(function()      
        return tile.Inner.Tags.ItemName      
    end)      
    if success and itemNamePath and itemNamePath:IsA("TextLabel") then      
        local name = itemNamePath.Text      
        if slowRods[name] or fastRods[name] then      
            return name      
        end      
    end      
end      
return nil

end

local function updateDelayBasedOnRod(showNotify)
if delayInitialized then return end

local rodName = getValidRodName()      
if rodName then      
    if slowRods[rodName] then       
        customDelay = math.random(210, 250) / 100      
    elseif fastRods[rodName] then      
        customDelay = math.random(110, 130) / 100      
    else      
        customDelay = 2.0      
    end      
    delayInitialized = true      
    if showNotify and autofish then      
        NotifySuccess("Rod Detected", string.format("Detected Rod: %s | Delay: %.2fs", rodName, customDelay))      
    end      
else      
    customDelay = 2      
    delayInitialized = true       
    if showNotify and autofish then      
        NotifyWarning("Rod Detection Failed", "No valid rod found in list. Default delay 2s applied.")      
    end      
end

end

local function setupRodWatcher()
    local player = Players.LocalPlayer
    local display = player.PlayerGui:WaitForChild("Backpack"):WaitForChild("Display")
    display.ChildAdded:Connect(function()
        task.wait(0.05)
        if not delayInitialized then
            updateDelayBasedOnRod(true)
        end
    end)
end
setupRodWatcher()

REReplicateTextEffect.OnClientEvent:Connect(function(data)
    if autofish and fishingActive
    and data
    and data.TextData
    and data.TextData.EffectType == "Exclaim" then

        local myHead = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Head")      
        if myHead and data.Container == myHead then      
            task.spawn(function()      
                for i = 1, 3 do
                    task.wait(BypassDelay)
                    finishRemote:FireServer()      
                    rconsoleclear()      
                    task.wait()      
                end      
            end)      
        end      
    end
end)

function StartAutoFish()
autofish = true
updateDelayBasedOnRod(true)

task.spawn(function()      
    while autofish do      
        pcall(function()      
            fishingActive = true      
  
            local equipRemote = net:WaitForChild("RE/EquipToolFromHotbar")      
            equipRemote:FireServer(1)      
            task.wait(0.1)      
  
            local chargeRemote = ReplicatedStorage      
                .Packages._Index["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]      
            chargeRemote:InvokeServer(workspace:GetServerTimeNow())      
                  
            task.wait(0.5)      
  
            local timestamp = workspace:GetServerTimeNow()      
            RodShake:Play()      
            rodRemote:InvokeServer(timestamp)      
  
            local baseX, baseY = -0.7499996423721313, 0.991067629351885      
            local x, y      
            if perfectCast then      
                x = baseX + (math.random(-500, 500) / 10000000)      
                y = baseY + (math.random(-500, 500) / 10000000)      
            else      
                x = math.random(-1000, 1000) / 1000      
                y = math.random(0, 1000) / 1000      
            end      
  
            RodIdle:Play()      
            miniGameRemote:InvokeServer(x, y)      
  
            task.wait(customDelay)      
  
            fishingActive = false      
        end)      
    end      
end)

end

function StopAutoFish()
autofish = false
fishingActive = false
delayInitialized = false
end

AutoFish:Input({
	Title = "Bypass Delay (Beta)",
	Desc = "Use 1 for rod above a Ares",
	Placeholder = "Example: 1",
	Value = nil,
	Callback = function(value)
		local number = tonumber(value)
		if number then
		  BypassDelay = number
			NotifySuccess("Bypass Delay", "Bypass Delay set to " .. number)
		else
		  NotifyError("Invalid Input", "Failed to convert input to number.")
		end
	end,
})

AutoFish:Toggle({
    Title = "Auto Fish",
    Callback = function(value)
        if value then
            StartAutoFish()
        else
            StopAutoFish()
        end
    end
})


local PerfectCast = AutoFish:Toggle({
    Title = "Auto Perfect Cast",
    Value = true,
    Callback = function(value)
        perfectCast = value
    end
})
myConfig:Register("Prefect", PerfectCast)


function sellAllFishes()
	local charFolder = workspace:FindFirstChild("Characters")
	local char = charFolder and charFolder:FindFirstChild(LocalPlayer.Name)
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		NotifyError("Character Not Found", "HRP tidak ditemukan.")
		return
	end

	local originalPos = hrp.CFrame
	local sellerPos = Vector3.new(-32, 5, 2885)
	local sellRemote = net:WaitForChild("RF/SellAllItems")

	task.spawn(function()
		NotifyInfo("Selling...", "I'm going to sell all the fish, please wait...", 3)

		hrp.CFrame = CFrame.new(sellerPos + Vector3.new(0, 3, 0))
		task.wait(1.5)
		local success, err = pcall(function()
			sellRemote:InvokeServer()
		end)

		if success then
			NotifySuccess("Sold!", "All the fish were sold successfully.", 3)
		else
			NotifyError("Sell Failed", tostring(err, 3))
		end

		task.wait(1)
		hrp.CFrame = originalPos
	end)
end

AutoFish:Button({
    Title = "Auto Enchant Rod",
    Callback = function()
        local ENCHANT_POSITION = Vector3.new(3231, -1303, 1402)
		local char = workspace:WaitForChild("Characters"):FindFirstChild(LocalPlayer.Name)
		local hrp = char and char:FindFirstChild("HumanoidRootPart")

		if not hrp then
			NotifyError("Auto Enchant Rod", "Failed to get character HRP.")
			return
		end

		NotifyInfo("Preparing Enchant...", "Please manually place Enchant Stone into slot 5 before we begin...", 5)

		task.wait(3)

		local Player = game:GetService("Players").LocalPlayer
		local slot5 = Player.PlayerGui.Backpack.Display:GetChildren()[10]

		local itemName = slot5 and slot5:FindFirstChild("Inner") and slot5.Inner:FindFirstChild("Tags") and slot5.Inner.Tags:FindFirstChild("ItemName")

		if not itemName or not itemName.Text:lower():find("enchant") then
			NotifyError("Auto Enchant Rod", "Slot 5 does not contain an Enchant Stone.")
			return
		end

		NotifyInfo("Enchanting...", "It is in the process of Enchanting, please wait until the Enchantment is complete", 7)

		local originalPosition = hrp.Position
		task.wait(1)
		hrp.CFrame = CFrame.new(ENCHANT_POSITION + Vector3.new(0, 5, 0))
		task.wait(1.2)

		local equipRod = net:WaitForChild("RE/EquipToolFromHotbar")
		local activateEnchant = net:WaitForChild("RE/ActivateEnchantingAltar")

		pcall(function()
			equipRod:FireServer(5)
			task.wait(0.5)
			activateEnchant:FireServer()
			task.wait(7)
			NotifySuccess("Enchant", "Successfully Enchanted!", 3)
		end)

		task.wait(0.9)
		hrp.CFrame = CFrame.new(originalPosition + Vector3.new(0, 3, 0))
    end
})


-------------------------------------------
----- =======[ AUTO FARM TAB ]
-------------------------------------------


local floatPlatform = nil

local function floatingPlat(enabled)
	if enabled then
			local charFolder = workspace:WaitForChild("Characters", 5)
			local char = charFolder:FindFirstChild(LocalPlayer.Name)
			if not char then return end

			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			floatPlatform = Instance.new("Part")
			floatPlatform.Anchored = true
			floatPlatform.Size = Vector3.new(10, 1, 10)
			floatPlatform.Transparency = 1
			floatPlatform.CanCollide = true
			floatPlatform.Name = "FloatPlatform"
			floatPlatform.Parent = workspace

			task.spawn(function()
				while floatPlatform and floatPlatform.Parent do
					pcall(function()
						floatPlatform.Position = hrp.Position - Vector3.new(0, 3.5, 0)
					end)
					task.wait(0.1)
				end
			end)

			NotifySuccess("Float Enabled", "This feature has been successfully activated!")
		else
			if floatPlatform then
				floatPlatform:Destroy()
				floatPlatform = nil
			end
			NotifyWarning("Float Disabled", "Feature disabled")
		end
end

  
local LocalPlayer = Players.LocalPlayer  
local workspace = game:GetService("Workspace")

local knownEvents = {}

-- Mapping kode → nama event
local eventCodes = {
	["1"] = "Ghost Shark Hunt",
	["2"] = "Shark Hunt",
	["3"] = "Worm Hunt",
	["4"] = "Black Hole",
	["5"] = "Meteor Rain",
	["6"] = "Ghost Worm",
	["7"] = "Shocked"
}

local function teleportTo(position)
	local char = workspace:FindFirstChild("Characters"):FindFirstChild(LocalPlayer.Name)
	if char then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = CFrame.new(position + Vector3.new(0, 10, 0))
		end
	end
end

local function updateKnownEvents()
	knownEvents = {}

	local props = workspace:FindFirstChild("Props")
	if props then
		for _, child in ipairs(props:GetChildren()) do
			if child:IsA("Model") and child.PrimaryPart then
				knownEvents[child.Name:lower()] = child
			end
		end
	end
end

local function monitorEvents()
	local props = workspace:FindFirstChild("Props")
	if not props then
		workspace.ChildAdded:Connect(function(child)
			if child.Name == "Props" then
				task.wait(0.3)
				monitorEvents()
			end
		end)
		return
	end

	props.ChildAdded:Connect(function()
		task.wait(0.3)
		updateKnownEvents()
	end)

	props.ChildRemoved:Connect(function()
		task.wait(0.3)
		updateKnownEvents()
	end)

	updateKnownEvents()
end

monitorEvents()

local autoTPEvent = false
local savedCFrame = nil
local monitoringTP = false
local alreadyTeleported = false
local teleportTime = nil -- waktu saat teleport

local function saveOriginalPosition()
	local char = workspace:FindFirstChild("Characters"):FindFirstChild(LocalPlayer.Name)
	if char and char:FindFirstChild("HumanoidRootPart") then
		savedCFrame = char.HumanoidRootPart.CFrame
	end
end

local function returnToOriginalPosition()
	if savedCFrame then
		local char = workspace:FindFirstChild("Characters"):FindFirstChild(LocalPlayer.Name)
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = savedCFrame
		end
	end
end

local function monitorAutoTP()
	if monitoringTP then return end
	monitoringTP = true

	while true do
		if autoTPEvent then
			if next(knownEvents) ~= nil then
				for _, eventModel in pairs(knownEvents) do
					if not alreadyTeleported then
						saveOriginalPosition()
						teleportTo(eventModel:GetPivot().Position)
						if typeof(floatingPlat) == "function" then
							floatingPlat(true)
						end
						alreadyTeleported = true
						teleportTime = tick()
						NotifyError("Event Farm", "Teleported to: " .. eventModel.Name)
					end
					break
				end
			else
				-- Event hilang sebelum 15 menit
				if alreadyTeleported then
					returnToOriginalPosition()
					if typeof(floatingPlat) == "function" then
						floatingPlat(false)
					end
					alreadyTeleported = false
					teleportTime = nil
					NotifyInfo("Event Ended", "Returned to start position.")
				end
			end

			if alreadyTeleported and teleportTime and (tick() - teleportTime >= 900) then
				returnToOriginalPosition()
				if typeof(floatingPlat) == "function" then
					floatingPlat(false)
				end
				alreadyTeleported = false
				teleportTime = nil
				NotifyInfo("Event Timeout", "Returned after 15 minutes.")
			end
		else
			-- Jika toggle dimatikan, pastikan balik
			if alreadyTeleported then
				returnToOriginalPosition()
				if typeof(floatingPlat) == "function" then
					floatingPlat(false)
				end
				alreadyTeleported = false
				teleportTime = nil
			end
		end

		task.wait(1)
	end
end

task.spawn(monitorAutoTP)

local selectedIsland = "01"
local isAutoFarmRunning = false

local islandCodes = {
    ["01"] = "Crater Islands",
    ["02"] = "Tropical Grove",
    ["03"] = "Vulcano",
    ["04"] = "Coral Reefs",
    ["05"] = "Winter",
    ["06"] = "Machine",
    ["07"] = "Treasure Room",
    ["08"] = "Sisyphus Statue"
}

local farmLocations = {
    ["Crater Islands"] = {
    	CFrame.new(1066.1864, 57.2025681, 5045.5542, -0.682534158, 1.00865822e-08, 0.730853677, -5.8900711e-09, 1, -1.93017531e-08, -0.730853677, -1.74788859e-08, -0.682534158),
    	CFrame.new(1057.28992, 33.0884132, 5133.79883, 0.833871782, 5.44149223e-08, 0.551958203, -6.58184218e-09, 1, -8.86416984e-08, -0.551958203, 7.02829084e-08, 0.833871782),
    	CFrame.new(988.954712, 42.8254471, 5088.71289, -0.849417388, -9.89310394e-08, 0.527721584, -5.96115086e-08, 1, 9.15179328e-08, -0.527721584, 4.62786431e-08, -0.849417388),
    },
    ["Tropical Grove"] = {
    	CFrame.new(-2165.05469, 2.77070165, 3639.87451, -0.589090407, -3.61497356e-08, -0.808067143, -3.20645626e-08, 1, -2.13606164e-08, 0.808067143, 1.3326984e-08, -0.589090407)
    },
    ["Vulcano"] = {
    	CFrame.new(-701.447937, 48.1446075, 93.1546631, -0.0770962164, 1.34335654e-08, -0.997023642, 9.84464776e-09, 1, 1.27124169e-08, 0.997023642, -8.83526763e-09, -0.0770962164),
    	CFrame.new(-654.994934, 57.2567711, 75.098526, -0.540957272, 2.58946509e-09, -0.841050088, -7.58775585e-08, 1, 5.18827363e-08, 0.841050088, 9.1883166e-08, -0.540957272),
    },
    ["Coral Reefs"] = {
    	CFrame.new(-3118.39624, 2.42531538, 2135.26392, 0.92336154, -1.0069185e-07, -0.383931547, 8.0607947e-08, 1, -6.84016968e-08, 0.383931547, 3.22115596e-08, 0.92336154),
    },
    ["Winter"] = {
    	CFrame.new(2036.15308, 6.54998732, 3381.88916, 0.943401575, 4.71338666e-08, -0.331652641, -3.28136842e-08, 1, 4.87781051e-08, 0.331652641, -3.51345975e-08, 0.943401575),
    },
    ["Machine"] = {
    	CFrame.new(-1459.3772, 14.7103214, 1831.5188, 0.777951121, 2.52131862e-08, -0.628324807, -5.24126378e-08, 1, -2.47663063e-08, 0.628324807, 5.21991339e-08, 0.777951121)
    },
    ["Treasure Room"] = {
    	CFrame.new(-3625.0708, -279.074219, -1594.57605, 0.918176472, -3.97606392e-09, -0.396171629, -1.12946204e-08, 1, -3.62128851e-08, 0.396171629, 3.77244298e-08, 0.918176472),
    	CFrame.new(-3600.72632, -276.06427, -1640.79663, -0.696130812, -6.0491181e-09, 0.717914939, -1.09490363e-08, 1, -2.19084972e-09, -0.717914939, -9.38559541e-09, -0.696130812)
    },
    ["Sisyphus Statue"] = {
    	CFrame.new(-3722.92139, -101.130035, -955.649902, 0.777723014, -1.41385739e-08, 0.628607094, -2.57670365e-08, 1, 5.43713092e-08, -0.628607094, -5.84831632e-08, 0.777723014),
    	CFrame.new(-3722.92139, -101.130035, -955.649902, 0.777723014, -1.41385739e-08, 0.628607094, -2.57670365e-08, 1, 5.43713092e-08, -0.628607094, -5.84831632e-08, 0.777723014)
    }
}


local function parseNumberWithDot(str)
    if typeof(str) ~= "string" or str == "" then return nil end
    local clean = str:gsub("%.", "")
    if clean == "" then return nil end
    return tonumber(clean)
end
      
local obtainedFishUUIDs = {}
local obtainedLimit = 30 -- bisa diubah sesuai kebutuhan

local Remote = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net["RE/ObtainedNewFishNotification"]
Remote.OnClientEvent:Connect(function(_, _, data)
    if data and data.InventoryItem and data.InventoryItem.UUID then
        table.insert(obtainedFishUUIDs, data.InventoryItem.UUID)
    end
end)

local function sellItems()
    if #obtainedFishUUIDs > 0 then
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index")
            :WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/SellAllItems"):InvokeServer()
    end

    obtainedFishUUIDs = {}
end

local function startAutoFarmLoop()
    NotifySuccess("Auto Farm Enabled", "Fishing started on island: " .. selectedIsland)

    while isAutoFarmRunning do  
        local islandSpots = farmLocations[selectedIsland]  
        if type(islandSpots) == "table" and #islandSpots > 0 then  
            location = islandSpots[math.random(1, #islandSpots)]  
        else  
            location = islandSpots  
        end  

        if not location then  
            NotifyError("Invalid Island", "Selected island name not found.")  
            return  
        end  

        local char = workspace:FindFirstChild("Characters"):FindFirstChild(LocalPlayer.Name)  
        local hrp = char and char:FindFirstChild("HumanoidRootPart")  
        if not hrp then  
            NotifyError("Teleport Failed", "HumanoidRootPart not found.")  
            return  
        end  

        hrp.CFrame = location  
        task.wait(1.5)  

        StartAutoFish()  

        while isAutoFarmRunning do
            repeat  
                if not isAutoFarmRunning then break end  
                task.wait(0.3)  
            until #obtainedFishUUIDs >= obtainedLimit  

            if not isAutoFarmRunning then  
                StopAutoFish()  
                NotifyWarning("Auto Farm Stopped", "Auto Farm manually disabled. Auto Fish stopped.")  
                break  
            end  

            NotifyInfo("Fish Threshold Reached", "Selling all fishes...")  
            sellItems()  
            obtainedFishUUIDs = {}
            task.wait(0.5)
        end
    end
end      


local islandCodes = {
    ["01"] = "Crater Islands",
    ["02"] = "Tropical Grove",
    ["03"] = "Vulcano",
    ["04"] = "Coral Reefs",
    ["05"] = "Winter",
    ["06"] = "Machine",
    ["07"] = "Treasure Room",
    ["08"] = "Sisyphus Statue"
}

-- Buat array nama island dan mapping terbalik
local nameList = {}
local islandNamesToCode = {}

for code, name in pairs(islandCodes) do
    table.insert(nameList, name)
    islandNamesToCode[name] = code
end

table.sort(nameList)

local CodeIsland = AutoFarmTab:Dropdown({
    Title = "Farm Island",
    Values = nameList,
    Value = nameList[1], -- default value
    Callback = function(selectedName)
        local code = islandNamesToCode[selectedName]
        local islandName = islandCodes[code]
        if islandName and farmLocations[islandName] then
            selectedIsland = islandName
            NotifySuccess("Island Selected", "Farming location set to " .. islandName)
        else
            NotifyError("Invalid Selection", "The island name is not recognized.")
        end
    end
})

myConfig:Register("IslCode", CodeIsland)

local FishThres = AutoFarmTab:Input({
	Title = "Fish Threshold",
	Placeholder = "Example: 1500",
	Value = nil,
	Callback = function(value)
		local number = tonumber(value)
		if number then
		  obtainedLimit = number
			NotifySuccess("Threshold Set", "Fish threshold set to " .. number)
		else
		  NotifyError("Invalid Input", "Failed to convert input to number.")
		end
	end,
})

myConfig:Register("FishThreshold", FishThres)

local AutoFarm = AutoFarmTab:Toggle({
	Title = "Start Auto Farm",
	Callback = function(state)
		isAutoFarmRunning = state
		if state then
			startAutoFarmLoop()
		else
			StopAutoFish()
		end
	end
})

AutoFarmTab:Button({
    Title = "Sell All Fishes",
    Locked = false,
    Callback = function()
        sellAllFishes()
    end
})

myConfig:Register("AutoFarmStart", AutoFarm)

AutoFarmTab:Toggle({
	Title = "Auto Farm Event",
	Desc = "!! DO WITH YOUR OWN RISK !!",
	Value = false,
	Callback = function(state)
		autoTPEvent = state
		if autoTPEvent then
			monitorAutoTP()
		else
			if alreadyTeleported then
				returnToOriginalPosition()
				if typeof(floatingPlat) == "function" then
					floatingPlat(false)
				end
				alreadyTeleported = false
			end
		end
	end
})


-------------------------------------------
----- =======[ AUTO WEATHER TAB ]
-------------------------------------------


local weatherActive = false
local weatherData = {
    ["Storm"] = {
        duration = 600
    },
    ["Cloudy"] = {
        duration = 600
    },
    ["Snow"] = {
        duration = 600
    },
    ["Wind"] = {
        duration = 600
    }
}

local function randomDelay(min, max)
    return math.random(min * 100, max * 100) / 100
end

local function autoBuyWeather(weatherType)
    local purchaseRemote = ReplicatedStorage:WaitForChild("Packages")
        :WaitForChild("_Index")
        :WaitForChild("sleitnick_net@0.2.0")
        :WaitForChild("net")
        :WaitForChild("RF/PurchaseWeatherEvent")

    task.spawn(function()
        while weatherActive do
            pcall(function()
                purchaseRemote:InvokeServer(weatherType)
                NotifySuccess("Weather Purchased", "Successfully activated " .. weatherType)

                task.wait(weatherData[weatherType].duration)

                local randomWait = randomDelay(1, 5)
                NotifyInfo("Waiting...", "Delay before next purchase: " .. tostring(randomWait) .. "s")
                task.wait(randomWait)
            end)
        end
    end)
end

local WStorm = WeatherTab:Toggle({
    Title = "Storm",
    Callback = function(state)
        weatherActive = state
        if state then
            NotifyInfo("Auto Weather", "Auto buying Storm has started!")
            autoBuyWeather("Storm")
        else
            NotifyWarning("Auto Weather", "Auto buying has been stopped.")
        end
    end
})

myConfig:Register("WeatherStorm", WStorm)

local WCloudy = WeatherTab:Toggle({
    Title = "Cloudy",
    Callback = function(state)
        weatherActive = state
        if state then
            NotifyInfo("Auto Weather", "Auto buying Cloudy has started!")
            autoBuyWeather("Cloudy")
        else
            NotifyWarning("Auto Weather", "Auto buying has been stopped.")
        end
    end
})

myConfig:Register("WeatherCloudy", WCloudy)

local WSnow = WeatherTab:Toggle({
    Title = "Snow",
    Callback = function(state)
        weatherActive = state
        if state then
            NotifyInfo("Auto Weather", "Auto buying Snow has started!")
            autoBuyWeather("Snow")
        else
            NotifyWarning("Auto Weather", "Auto buying has been stopped.")
        end
    end
})

myConfig:Register("WeatherSnow", WSnow)

local WWind = WeatherTab:Toggle({
    Title = "Wind",
    Callback = function(state)
        weatherActive = state
        if state then
            NotifyInfo("Auto Weather", "Auto buying Wind has started!")
            autoBuyWeather("Wind")
        else
            NotifyWarning("Auto Weather", "Auto buying has been stopped.")
        end
    end
})

myConfig:Register("WeatherWind", WWind)

-------------------------------------------
----- =======[ PLAYER TAB ]
-------------------------------------------

-------------------------------------------
----- =======[ UTILITY TAB ]
-------------------------------------------


local islandCoords = {
	["01"] = { name = "Weather Machine", position = Vector3.new(-1471, -3, 1929) },
	["02"] = { name = "Esoteric Depths", position = Vector3.new(3157, -1303, 1439) },
	["03"] = { name = "Tropical Grove", position = Vector3.new(-2038, 3, 3650) },
	["04"] = { name = "Stingray Shores", position = Vector3.new(-32, 4, 2773) },
	["05"] = { name = "Kohana Volcano", position = Vector3.new(-519, 24, 189) },
	["06"] = { name = "Coral Reefs", position = Vector3.new(-3095, 1, 2177) },
	["07"] = { name = "Crater Island", position = Vector3.new(968, 1, 4854) },
	["08"] = { name = "Kohana", position = Vector3.new(-658, 3, 719) },
	["09"] = { name = "Winter Fest", position = Vector3.new(1611, 4, 3280) },
	["10"] = { name = "Isoteric Island", position = Vector3.new(1987, 4, 1400) },
	["11"] = { name = "Treasure Hall", position = Vector3.new(-3600, -267, -1558) },
	["12"] = { name = "Lost Shore", position = Vector3.new(-3663, 38, -989 )}
}

local islandNames = {}
for _, data in pairs(islandCoords) do
    table.insert(islandNames, data.name)
end

Utils:Dropdown({
    Title = "Island Selector",
    Desc = "Select island to teleport",
    Values = islandNames,
    Value = islandNames[1],
    Callback = function(selectedName)
        for code, data in pairs(islandCoords) do
            if data.name == selectedName then
                local success, err = pcall(function()
                    local charFolder = workspace:WaitForChild("Characters", 5)
                    local char = charFolder:FindFirstChild(LocalPlayer.Name)
                    if not char then error("Character not found") end
                    local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 3)
                    if not hrp then error("HumanoidRootPart not found") end
                    hrp.CFrame = CFrame.new(data.position + Vector3.new(0, 5, 0))
                end)

                if success then
                    NotifySuccess("Teleported!", "You are now at " .. selectedName)
                else
                    NotifyError("Teleport Failed", tostring(err))
                end
                break
            end
        end
    end
})



local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local HRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

local Items = ReplicatedStorage:WaitForChild("Items")
local Baits = ReplicatedStorage:WaitForChild("Baits")
local net = ReplicatedStorage:WaitForChild("Packages")
	:WaitForChild("_Index")
	:WaitForChild("sleitnick_net@0.2.0")
	:WaitForChild("net")


local npcCFrame = CFrame.new(
	66.866745, 4.62500143, 2858.98535,
	-0.981261611, 5.77215005e-08, -0.192680314,
	6.94250204e-08, 1, -5.39889484e-08,
	0.192680314, -6.63541186e-08, -0.981261611
)


local function FadeScreen(duration)
	local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false

	local frame = Instance.new("Frame", gui)
	frame.BackgroundColor3 = Color3.new(0, 0, 0)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1

	local tweenIn = TweenService:Create(frame, TweenInfo.new(0.2), { BackgroundTransparency = 0.9 })
	tweenIn:Play()
	tweenIn.Completed:Wait()

	wait(duration)

	local tweenOut = TweenService:Create(frame, TweenInfo.new(0.3), { BackgroundTransparency = 1 })
	tweenOut:Play()
	tweenOut.Completed:Wait()
	gui:Destroy()
end

local function SafePurchase(callback)
	local originalCFrame = HRP.CFrame
	HRP.CFrame = npcCFrame
	FadeScreen(0.9)
	pcall(callback)
	wait(1)
	HRP.CFrame = originalCFrame
end

-- RODS DROPDOWN
local rodOptions = {}
local rodData = {}

for _, rod in ipairs(Items:GetChildren()) do
	if rod:IsA("ModuleScript") and rod.Name:find("!!!") then
		local success, module = pcall(require, rod)
		if success and module and module.Data then
			local id = module.Data.Id
			local name = module.Data.Name or rod.Name
			local price = module.Price or module.Data.Price

			if price then
				table.insert(rodOptions, name .. " | Price: " .. tostring(price))
				rodData[name] = id
			end
		end
	end
end

Utils:Dropdown({
	Title = "Rod Shop",
	Desc = "Select Rod to Buy",
	Values = rodOptions,
	Value = nil,
	Callback = function(option)
		local selectedName = option:split(" |")[1]
		local id = rodData[selectedName]

		SafePurchase(function()
			net:WaitForChild("RF/PurchaseFishingRod"):InvokeServer(id)
			NotifySuccess("Rod Purchased", selectedName .. " has been successfully purchased!")
		end)
	end,
})


local baitOptions = {}
local baitData = {}

for _, bait in ipairs(Baits:GetChildren()) do
	if bait:IsA("ModuleScript") then
		local success, module = pcall(require, bait)
		if success and module and module.Data then
			local id = module.Data.Id
			local name = module.Data.Name or bait.Name
			local price = module.Price or module.Data.Price

			if price then
				table.insert(baitOptions, name .. " | Price: " .. tostring(price))
				baitData[name] = id
			end
		end
	end
end

Utils:Dropdown({
	Title = "Baits Shop",
	Desc = "Select Baits to Buy",
	Values = baitOptions,
	Value = nil,
	Callback = function(option)
		local selectedName = option:split(" |")[1]
		local id = baitData[selectedName]

		SafePurchase(function()
			net:WaitForChild("RF/PurchaseBait"):InvokeServer(id)
			NotifySuccess("Bait Purchased", selectedName .. " has been successfully purchased!")
		end)
	end,
})

local npcFolder = game:GetService("ReplicatedStorage"):WaitForChild("NPC")

local npcList = {}
for _, npc in pairs(npcFolder:GetChildren()) do
	if npc:IsA("Model") then
		local hrp = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
		if hrp then
			table.insert(npcList, npc.Name)
		end
	end
end


-------------------------------------------
----- =======[ SETTINGS TAB ]
-------------------------------------------


local AntiAFKEnabled = true
local AFKConnection = nil

SettingsTab:Toggle({
	Title = "Anti-AFK",
	Value = true,
	Callback = function(Value)
		AntiAFKEnabled = Value

		if AntiAFKEnabled then
			if AFKConnection then
				AFKConnection:Disconnect()
			end

			
			local LocalPlayer = Players.LocalPlayer
			local VirtualUser = game:GetService("VirtualUser")

			AFKConnection = LocalPlayer.Idled:Connect(function()
				pcall(function()
					VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
					task.wait(1)
					VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end)
			end)

			if NotifySuccess then
				NotifySuccess("Anti-AFK Activated", "You will now avoid being kicked.")
			end

		else
			if AFKConnection then
				AFKConnection:Disconnect()
				AFKConnection = nil
			end

			if NotifySuccess then
				NotifySuccess("Anti-AFK Deactivated", "You can now go idle again.")
			end
		end
	end,
})

SettingsTab:Button({
	Title = "Boost FPS (Maximize Performance)",
	Callback = function()
		for _, v in pairs(game:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
			elseif v:IsA("Decal") or v:IsA("Texture") then
				v.Transparency = 1
			end
		end

		local Lighting = game:GetService("Lighting")
		for _, effect in pairs(Lighting:GetChildren()) do
			if effect:IsA("PostEffect") then
				effect.Enabled = false
			end
		end

		Lighting.GlobalShadows = false
		Lighting.FogEnd = 1e10

		settings().Rendering.QualityLevel = "Level01"
	end
})

SettingsTab:Button({
	Title = "HDR Shader",
	Callback = function()
		loadstring(game:HttpGet("https://paste.monster/IVE9Xt3YJWkp/raw/"))()
	end,
})

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local function Rejoin()
	local player = Players.LocalPlayer
	if player then
		TeleportService:Teleport(game.PlaceId, player)
	end
end

local function ServerHop()
	local placeId = game.PlaceId
	local servers = {}
	local cursor = ""
	local found = false

	repeat
		local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
		if cursor ~= "" then
			url = url .. "&cursor=" .. cursor
		end

		local success, result = pcall(function()
			return HttpService:JSONDecode(game:HttpGet(url))
		end)

		if success and result and result.data then
			for _, server in pairs(result.data) do
				if server.playing < server.maxPlayers and server.id ~= game.JobId then
					table.insert(servers, server.id)
				end
			end
			cursor = result.nextPageCursor or ""
		else
			break
		end
	until not cursor or #servers > 0

	if #servers > 0 then
		local targetServer = servers[math.random(1, #servers)]
		TeleportService:TeleportToPlaceInstance(placeId, targetServer, LocalPlayer)
	else
		NotifyError("Server Hop Failed", "No servers available or all are full!")
	end
end

local Keybind = SettingsTab:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open UI",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

myConfig:Register("Keybind", Keybind)

SettingsTab:Button({
	Title = "Rejoin Server",
	Callback = function()
		Rejoin()
	end,
})

SettingsTab:Button({
	Title = "Server Hop (New Server)",
	Callback = function()
		ServerHop()
	end,
})


local WebhookURL = "https://discord.com/api/webhooks/1400783682125697217/ihd32FuINzV6zGYBp5dKR4dF2zTHmlwoN9yZAYvH_C-Vczad8uXppUS_az6KZq_GoC8X"      
local TargetKeywords = {      
    "shark",      
    "turtle",      
    "whale",      
    "worm",
    "robot kraken",
    "giant squid",
    "king crab",
    "blob fish",
    "seahorse",
    "ray",
    "dotted stingray",
    "lined cardinal fish"
       
}      

-- ✅ VARIABEL TOGGLE
local WebhookEnabled = true

-- ✅ UI TOGGLE
SettingsTab:Toggle({
    Title = "Fish Webhook",
    Value = true,
    Callback = function(value)
        WebhookEnabled = value
        if WebhookEnabled then
            NotifySuccess("Webhook ON", "Webhook Enabled.")
        else
            NotifyWarning("Webhook OFF", "Webhook Disabled")
        end
    end
})

-- ✅ CEK KATA KUNCI IKAN
local function isTargetFish(fishName)
	for _, keyword in pairs(TargetKeywords) do
		if string.find(string.lower(fishName), string.lower(keyword)) then
			return true
		end
	end
	return false
end

-- ✅ CARI GAMBAR DARI ASSET ID
local function GetRobloxImage(assetId)
	local url = "https://thumbnails.roblox.com/v1/assets?assetIds=" .. assetId .. "&size=420x420&format=Png&isCircular=false"
	local success, response = pcall(game.HttpGet, game, url)
	if success then
		local HttpService = game:GetService("HttpService")
		local data = HttpService:JSONDecode(response)
		if data and data.data and data.data[1] and data.data[1].imageUrl then
			return data.data[1].imageUrl
		end
	end
	return nil
end

-- ✅ KIRIM WEBHOOK
local function sendFishWebhook(fishName, rarityText, assetId)
	if not WebhookEnabled then return end -- ⛔ Cegah jika toggle off

	local HttpService = game:GetService("HttpService")
	local username = game:GetService("Players").LocalPlayer.DisplayName
	local imageUrl = GetRobloxImage(assetId)

	if not imageUrl then
		warn("❌ Gagal mendapatkan image URL untuk assetId:", assetId)
		return
	end

	local embedDesc = string.format([[
Hei **%s**! 🎣      
You have successfully caught a fish.

======| FISH DATA |======    
🧾 Name : **%s**      
🌟 Rarity : **%s**
]], username, fishName, rarityText)

	local data = {
		["username"] = "QuietXHub",
		["embeds"] = {{
			["title"] = "Fish Caught!",
			["description"] = embedDesc,
			["color"] = tonumber("0x00bfff"),
			["image"] = {
				["url"] = imageUrl
			},
			["footer"] = {
				["text"] = "Fish It Notifier • " .. os.date("%d %B %Y, %H:%M:%S")
			}
		}}
	}

	local requestFunc = syn and syn.request or http and http.request or http_request or request or fluxus and fluxus.request
	if requestFunc then
		requestFunc({
			Url = WebhookURL,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HttpService:JSONEncode(data)
		})
	else
		warn("❌ HttpRequest tidak tersedia di executor ini.")
	end
end

-- ✅ MONITOR IKAN YANG DIDAPAT
local function startFishDetection()
	local plr = game:GetService("Players").LocalPlayer
	local guiNotif = plr.PlayerGui:WaitForChild("Small Notification"):WaitForChild("Display"):WaitForChild("Container")

	local fishText = guiNotif:WaitForChild("ItemName")
	local rarityText = guiNotif:WaitForChild("Rarity")
	local imageFrame = plr.PlayerGui["Small Notification"]:WaitForChild("Display"):WaitForChild("VectorFrame"):WaitForChild("Vector")

	fishText:GetPropertyChangedSignal("Text"):Connect(function()
		local fishName = fishText.Text
		if isTargetFish(fishName) then
			local rarity = rarityText.Text
			local assetId = string.match(imageFrame.Image, "%d+")
			if assetId then
				sendFishWebhook(fishName, rarity, assetId)
			end
		end
	end)
end

-- ✅ EKSEKUSI
startFishDetection()

SettingsTab:Button({
    Title = "Save",
    Desc = "Save Settings to config",
    Callback = function()
        myConfig:Save()
        NotifySuccess("Config Saved", "Config has been saved!")
    end
})

SettingsTab:Button({
    Title = "Load",
    Desc = "Loads Settings from config.",
    Callback = function()
        myConfig:Load()
        NotifySuccess("Config Loaded", "Config has beed loaded!")
    end
})