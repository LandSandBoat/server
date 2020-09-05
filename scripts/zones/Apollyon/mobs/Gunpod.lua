-----------------------------------
-- Area: Apollyon Central
--  Mob: Gunpod
-----------------------------------
local loot = 
{
    [1] = -- AF
    {
        {
            {itemid = 1933, droprate =  9}, -- MNK
            {itemid = 1931, droprate = 53}, -- WAR
            {itemid = 1959, droprate =  6}, -- SMN
            {itemid = 1935, droprate = 12}, -- WHM
            {itemid = 1945, droprate = 29}, -- DRK
            {itemid = 1957, droprate = 12}, -- DRG
            {itemid = 1949, droprate = 35}, -- BRD
            {itemid = 2659, droprate = 35}, -- COR
            {itemid = 1939, droprate = 12}, -- RDM
            {itemid = 1951, droprate = 12}, -- RNG
            {itemid = 2661, droprate = 12}, -- PUP
            {itemid = 1937, droprate = 18}, -- BLM
            {itemid = 1955, droprate = 29}, -- NIN
            {itemid = 2717, droprate = 12}, -- SCH
            {itemid = 1947, droprate = 12}, -- BST
            {itemid = 2657, droprate = 18}, -- BLU
            {itemid = 2715, droprate =  5}, -- DNC
            {itemid = 1953, droprate = 35}, -- SAM
            {itemid = 1941, droprate = 41}, -- THF
            {itemid = 1943, droprate = 18}, -- PLD
        },
    },
    [2] = -- Chip
    {
        {
            {itemid = 1987, droprate = 53}, -- Charcoal Chip
            {itemid = 1988, droprate = 76}, -- Magenta Chip
            {itemid = 1909, droprate = 64}, -- Smalt Chip
            {itemid = 1910, droprate = 41}, -- Smoky Chip
        },
    },
    [3] = -- Crafting
    {
        {
            {itemid =  646, droprate = 50}, -- Adaman Ore
            {itemid = 1633, droprate = 50}, -- Clot Plasma
            {itemid =  664, droprate = 50}, -- Darksteel Sheet
            {itemid =  645, droprate = 50}, -- Darksteel Ore
            {itemid = 1311, droprate = 50}, -- Oxblood
            {itemid = 1681, droprate = 50}, -- Light Steel
            {itemid =  821, droprate = 50}, -- Rainbow Thread
            {itemid = 1883, droprate = 50}, -- Shell Powder
        },
    },
    [4] = -- ABCs
    {
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid =    0, droprate = 1000}, -- Ancient Beastcoin
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
    },
}

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local players = mob:getBattlefield():getPlayers()
        local random = math.random(1, 4)
        for i = 1, #loot[random] do
            local lootGroup = loot[random][i]
            if lootGroup then
                local max = 0
                for _, entry in pairs(lootGroup) do
                    max = max + entry.droprate
                end
                local roll = math.random(max)
                for _, entry in pairs(lootGroup) do
                    max = max - entry.droprate
                    if roll > max then
                        if entry.itemid ~= 0 then
                            players[1]:addTreasure(entry.itemid, mob)
                        end
                        break
                    end
                end
            end
        end
    end
end
