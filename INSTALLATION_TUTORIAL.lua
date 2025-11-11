--[[
🌸 BLOOM FRAMEWORK v1.0.0 - Installation Tutorial
Made by HappyScripterDev (Collyn)

📦 QUICK INSTALLATION GUIDE:

🔥 SUPER EASY 3-STEP SETUP:

1️⃣ REPLICATEDSTORAGE SETUP:
   • Open "ReplicatedStorage" model in this file
   • Drag the "Bloom" folder → Your game's ReplicatedStorage
   
2️⃣ SERVER SETUP:
   • Open "ServerScriptService" model in this file
   • Drag "BloomServer" folder → Your game's ServerScriptService
   
3️⃣ CLIENT SETUP:
   • Open "StarterPlayerScripts" model in this file
   • Drag "BloomClient" folder → StarterPlayer > StarterPlayerScripts

✅ VERIFICATION - Your Explorer should show:
ReplicatedStorage/
└── Bloom/ (with init, Modules, Services)

ServerScriptService/
└── BloomServer/ (with init ServerScript)

StarterPlayer/StarterPlayerScripts/
└── BloomClient/ (with init LocalScript)

🚀 TEST YOUR SETUP:
1. Run your game
2. Check Output for: "🌸 Bloom Framework v1.0.0 initialized successfully!"
3. If you see this message - YOU'RE READY TO CODE! 🎉

💡 FIRST STEPS:
-- Server Script Example:
local RS = game:GetService("ReplicatedStorage")
local Bloom = require(RS.Bloom)
local bloom = Bloom.new()
bloom:Init()
bloom:Start()

🔗 RESOURCES:
• Full Documentation: https://github.com/HappyScripterDev/Bloom-Framework
• Creator Portfolio: https://collyns-portfolio.netlify.app/
• Need Help? Check the GitHub repository!

⚠️ DELETE THIS SCRIPT after installation is complete.

Happy coding with Bloom Framework! 🌸💖
--]]
