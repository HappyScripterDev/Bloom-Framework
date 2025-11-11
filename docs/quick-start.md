# 🚀 Quick Start Guide

Get up and running with Bloom Framework in under 5 minutes!

## 📦 Installation

### Step 1: Download Framework
1. Go to [Releases](https://github.com/HappyScripterDev/Bloom-Framework/releases/latest)
2. Download `BloomFramework.rbxm`
3. Import into Roblox Studio

### Step 2: Setup Framework
```lua
-- Follow the installation tutorial script included in the model:

-- 1. Drag "Bloom" folder → ReplicatedStorage
-- 2. Drag "BloomServer" folder → ServerScriptService  
-- 3. Drag "BloomClient" folder → StarterPlayerScripts
```

### Step 3: Verify Installation
Run your game and check Output for:
```
🌸 Bloom Framework v1.0.0 initialized successfully!
```

## 💡 Your First Script

### Server Script
```lua
local RS = game:GetService("ReplicatedStorage")
local Bloom = require(RS.Bloom)
local bloom = Bloom.new()

bloom:Init()
bloom:Start()

-- Use services
local dataService = bloom:GetService("DataService")
local eventService = bloom:GetService("EventService")

-- Handle player joining
eventService:Connect("PlayerJoined", function(player)
    print(player.Name .. " joined! 🌸")
    
    -- Load player data
    dataService:LoadPlayerData(player)
    
    -- Set default coins if new player
    local coins = dataService:GetPlayerData(player, "coins")
    if not coins then
        dataService:SetPlayerData(player, "coins", 100)
        print("Gave " .. player.Name .. " 100 starting coins!")
    end
end)
```

### Client Script
```lua
local RS = game:GetService("ReplicatedStorage")
local Bloom = require(RS.Bloom)
local bloom = Bloom.new()

bloom:Init()
bloom:Start()

-- Create UI
local uiService = bloom:GetService("UIService")
local gui = uiService:CreateScreenGui("GameGUI")

-- Create coin display
local coinFrame = uiService:CreateFrame(gui, {
    Size = UDim2.new(0, 200, 0, 60),
    Position = UDim2.new(0, 20, 0, 20),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
})

local coinLabel = Instance.new("TextLabel")
coinLabel.Size = UDim2.new(1, 0, 1, 0)
coinLabel.BackgroundTransparency = 1
coinLabel.Font = Enum.Font.GothamBold
coinLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
coinLabel.TextScaled = true
coinLabel.Text = "💰 Coins: 0"
coinLabel.Parent = coinFrame

-- Animate UI
uiService:FadeIn(coinFrame, 0.5)
```

## 🎯 Next Steps

1. **Explore Services**: Learn about DataService, UIService, EventService
2. **Check Examples**: See real-world usage in `/examples` folder
3. **Read API Docs**: Complete reference in `/docs/api-reference.md`
4. **Join Community**: Get help and share your creations!

## 🆘 Need Help?

- 📚 [Full Documentation](api-reference.md)
- 💬 [GitHub Discussions](https://github.com/HappyScripterDev/Bloom-Framework/discussions)
- 🐛 [Report Issues](https://github.com/HappyScripterDev/Bloom-Framework/issues)

---

**Ready to build amazing games with Bloom! 🌸**
