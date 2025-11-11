local RS = game:GetService("ReplicatedStorage")
local Bloom = require(RS.Bloom)
local bloom = Bloom.new()

bloom:Init()

local eventService = bloom:GetService("EventService")
local dataService = bloom:GetService("DataService")
local net = bloom:GetModule("Net")

local SHOP_ITEMS = {
    sword = {name = "⚔️ Iron Sword", cost = 50},
    shield = {name = "🛡️ Wooden Shield", cost = 30},
    potion = {name = "🧪 Health Potion", cost = 20}
}

eventService:Connect("PlayerJoined", function(player)
    print("🌸 " .. player.Name .. " joined the game!")
    
    local coins = dataService:GetPlayerData(player, "coins")
    if not coins then
        dataService:SetPlayerData(player, "coins", 100)
        print("💰 Gave " .. player.Name .. " 100 starting coins")
    end
end)

net:OnServerEvent("RequestCoins", function(player)
    local coins = dataService:GetPlayerData(player, "coins") or 0
    net:FireClient("UpdateCoins", player, coins)
end)

net:OnServerEvent("BuyItem", function(player, itemId)
    local item = SHOP_ITEMS[itemId]
    if not item then
        net:FireClient("PurchaseFailed", player, "Item not found")
        return
    end
    
    local coins = dataService:GetPlayerData(player, "coins") or 0
    
    if coins >= item.cost then
        dataService:SetPlayerData(player, "coins", coins - item.cost)
        net:FireClient("UpdateCoins", player, coins - item.cost)
        net:FireClient("PurchaseSuccess", player, item.name)
        
        print("🛒 " .. player.Name .. " bought " .. item.name)
    else
        net:FireClient("PurchaseFailed", player, "Not enough coins")
    end
end)

net:OnServerEvent("AddCoins", function(player, amount)
    local coins = dataService:GetPlayerData(player, "coins") or 0
    dataService:SetPlayerData(player, "coins", coins + amount)
    net:FireClient("UpdateCoins", player, coins + amount)
    print("💎 Added " .. amount .. " coins to " .. player.Name)
end)

print("🌸 Coin Game server loaded with Bloom Framework!")
