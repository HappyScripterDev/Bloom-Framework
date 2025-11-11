local RS = game:GetService("ReplicatedStorage")
local Bloom = require(RS.Bloom)
local bloom = Bloom.new()

bloom:Init()

local uiService = bloom:GetService("UIService")
local eventService = bloom:GetService("EventService")
local net = bloom:GetModule("Net")
local state = bloom:GetModule("State")

local gameState = state.new({
    coins = 0,
    shopOpen = false
})

local gui = uiService:CreateScreenGui("CoinGameGUI")

local coinFrame = uiService:CreateFrame(gui, {
    Size = UDim2.new(0, 220, 0, 70),
    Position = UDim2.new(0, 20, 0, 20),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
})

local coinLabel = Instance.new("TextLabel")
coinLabel.Size = UDim2.new(1, -20, 1, -20)
coinLabel.Position = UDim2.new(0, 10, 0, 10)
coinLabel.BackgroundTransparency = 1
coinLabel.Font = Enum.Font.GothamBold
coinLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
coinLabel.TextScaled = true
coinLabel.Text = "💰 Coins: 0"
coinLabel.Parent = coinFrame

local shopButton = uiService:CreateButton(gui, {
    Size = UDim2.new(0, 150, 0, 50),
    Position = UDim2.new(0, 20, 0, 110),
    Text = "🛒 Open Shop",
    BackgroundColor3 = Color3.fromRGB(70, 130, 255)
}, function()
    gameState:Set("shopOpen", not gameState:Get("shopOpen"))
end)

local addCoinsButton = uiService:CreateButton(gui, {
    Size = UDim2.new(0, 150, 0, 50),
    Position = UDim2.new(0, 190, 0, 110),
    Text = "💎 Add 50 Coins",
    BackgroundColor3 = Color3.fromRGB(50, 200, 50)
}, function()
    net:FireServer("AddCoins", 50)
end)

local shopFrame = uiService:CreateFrame(gui, {
    Size = UDim2.new(0, 350, 0, 400),
    Position = UDim2.new(0.5, -175, 0.5, -200),
    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
    Visible = false
})

local shopTitle = Instance.new("TextLabel")
shopTitle.Size = UDim2.new(1, -20, 0, 50)
shopTitle.Position = UDim2.new(0, 10, 0, 10)
shopTitle.BackgroundTransparency = 1
shopTitle.Font = Enum.Font.GothamBold
shopTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
shopTitle.TextScaled = true
shopTitle.Text = "🛒 BLOOM SHOP"
shopTitle.Parent = shopFrame

local items = {
    {id = "sword", name = "⚔️ Iron Sword", cost = 50},
    {id = "shield", name = "🛡️ Wooden Shield", cost = 30},
    {id = "potion", name = "🧪 Health Potion", cost = 20}
}

for i, item in ipairs(items) do
    local itemButton = uiService:CreateButton(shopFrame, {
        Size = UDim2.new(1, -20, 0, 60),
        Position = UDim2.new(0, 10, 0, 60 + (i-1) * 70),
        Text = item.name .. "\n💰 " .. item.cost .. " coins",
        BackgroundColor3 = Color3.fromRGB(60, 120, 200)
    }, function()
        net:FireServer("BuyItem", item.id)
    end)
end

local closeButton = uiService:CreateButton(shopFrame, {
    Size = UDim2.new(1, -20, 0, 50),
    Position = UDim2.new(0, 10, 1, -70),
    Text = "❌ Close Shop",
    BackgroundColor3 = Color3.fromRGB(200, 60, 60)
}, function()
    gameState:Set("shopOpen", false)
end)

gameState:Subscribe("coins", function(newCoins)
    coinLabel.Text = "💰 Coins: " .. newCoins
    uiService:Bounce(coinFrame, 1.05, 0.3)
end)

gameState:Subscribe("shopOpen", function(isOpen)
    if isOpen then
        shopFrame.Visible = true
        uiService:SlideIn(shopFrame, "down", 0.5)
        shopButton.Text = "🛒 Close Shop"
    else
        uiService:FadeOut(shopFrame, 0.3, function()
            shopFrame.Visible = false
        end)
        shopButton.Text = "🛒 Open Shop"
    end
end)

net:OnClientEvent("UpdateCoins", function(coins)
    gameState:Set("coins", coins)
end)

net:OnClientEvent("PurchaseSuccess", function(itemName)
    eventService:Fire("ShowNotification", "✅ Bought " .. itemName .. "!", Color3.fromRGB(50, 200, 50))
end)

net:OnClientEvent("PurchaseFailed", function(reason)
    eventService:Fire("ShowNotification", "❌ " .. reason, Color3.fromRGB(200, 50, 50))
end)

eventService:Connect("ShowNotification", function(text, color)
    local notif = uiService:CreateFrame(gui, {
        Size = UDim2.new(0, 350, 0, 60),
        Position = UDim2.new(0.5, -175, 0, -70),
        BackgroundColor3 = color
    })
    
    local notifLabel = Instance.new("TextLabel")
    notifLabel.Size = UDim2.new(1, -20, 1, -20)
    notifLabel.Position = UDim2.new(0, 10, 0, 10)
    notifLabel.BackgroundTransparency = 1
    notifLabel.Font = Enum.Font.GothamBold
    notifLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifLabel.TextScaled = true
    notifLabel.Text = text
    notifLabel.Parent = notif
    
    uiService:SlideIn(notif, "down", 0.3, function()
        task.wait(2)
        uiService:SlideIn(notif, "up", 0.3, function()
            notif:Destroy()
        end)
    end)
end)

uiService:FadeIn(coinFrame, 0.5)
uiService:SlideIn(shopButton, "left", 0.7)
uiService:SlideIn(addCoinsButton, "right", 0.7)

net:FireServer("RequestCoins")

print("🌸 Coin Game client loaded with Bloom Framework!")
