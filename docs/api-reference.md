# 🔧 API Reference

Complete documentation for all Bloom Framework components.

## 🏗️ Core Framework

### Bloom Class

Main framework entry point.

```lua
local Bloom = require(RS.Bloom)
local bloom = Bloom.new()
```

#### Methods

##### `bloom:Init()`
Initializes all modules and services.
```lua
bloom:Init()
```

##### `bloom:Start()`
Starts all services. Call after Init().
```lua
bloom:Start()
```

##### `bloom:GetService(name: string)`
Returns a service by name.
```lua
local dataService = bloom:GetService("DataService")
local uiService = bloom:GetService("UIService")
```

##### `bloom:GetModule(name: string)`
Returns a module by name.
```lua
local net = bloom:GetModule("Net")
local util = bloom:GetModule("Util")
```

---

## 🔧 Services

### DataService

Handles player data persistence.

#### Methods

##### `dataService:LoadPlayerData(player: Player)`
Loads player data from DataStore.
```lua
local data = dataService:LoadPlayerData(player)
```

##### `dataService:SavePlayerData(player: Player)`
Saves player data to DataStore.
```lua
dataService:SavePlayerData(player)
```

##### `dataService:GetPlayerData(player: Player, key?: string)`
Gets cached player data.
```lua
local coins = dataService:GetPlayerData(player, "coins")
local allData = dataService:GetPlayerData(player)
```

##### `dataService:SetPlayerData(player: Player, key: string, value: any)`
Sets player data in cache.
```lua
dataService:SetPlayerData(player, "coins", 500)
```

### UIService

UI creation and animation utilities.

#### Methods

##### `uiService:CreateScreenGui(name: string)`
Creates a ScreenGui.
```lua
local gui = uiService:CreateScreenGui("MainGUI")
```

##### `uiService:CreateButton(parent: Instance, props: table, onClick: function)`
Creates a styled button.
```lua
local button = uiService:CreateButton(frame, {
    Size = UDim2.new(0, 200, 0, 50),
    Text = "Click Me!"
}, function()
    print("Button clicked!")
end)
```

##### `uiService:FadeIn(element: GuiObject, duration?: number)`
Fades in an element.
```lua
uiService:FadeIn(frame, 0.5)
```

### EventService

Custom event system.

#### Methods

##### `eventService:Fire(name: string, ...args)`
Fires an event.
```lua
eventService:Fire("PlayerLevelUp", player, newLevel)
```

##### `eventService:Connect(name: string, callback: function)`
Connects to an event.
```lua
eventService:Connect("PlayerLevelUp", function(player, level)
    print(player.Name .. " reached level " .. level)
end)
```

---

## 📦 Modules

### Net Module

Simplified networking.

#### Methods

##### `net:FireServer(name: string, ...args)` (Client)
Fires event to server.
```lua
net:FireServer("BuyItem", "sword", 100)
```

##### `net:FireClient(name: string, player: Player, ...args)` (Server)
Fires event to client.
```lua
net:FireClient("UpdateCoins", player, 500)
```

### State Module

Reactive state management.

#### Constructor
```lua
local state = State.new({score = 0, level = 1})
```

#### Methods

##### `state:Set(key: string, value: any)`
Sets a state value.
```lua
state:Set("score", 100)
```

##### `state:Get(key?: string)`
Gets state value(s).
```lua
local score = state:Get("score")
local allState = state:Get()
```

##### `state:Subscribe(key: string, callback: function)`
Subscribes to changes.
```lua
state:Subscribe("score", function(newScore, oldScore)
    print("Score changed:", oldScore, "→", newScore)
end)
```

### Util Module

Common utilities.

#### Methods

##### `Util.DeepCopy(table: table)`
Deep copies a table.
```lua
local copy = Util.DeepCopy(originalTable)
```

##### `Util.Clamp(value: number, min: number, max: number)`
Clamps a value.
```lua
local clamped = Util.Clamp(150, 0, 100) -- Returns 100
```

---

For more examples, see the [Examples](../examples/) folder! 🌸
