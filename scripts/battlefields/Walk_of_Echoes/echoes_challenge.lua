-----------------------------------
-- First Walk
-- Walk of Echoes (Zone 182) - Level 30 Cap
-- Entry NPC: Dungeon Master at (-406.906, 14.000, -60.399)
-- Exit  NPC: Walk_Exit at (238, -8, -248) inside the arena
-- Boss:  3x Caldera Crab (groupid 1, spawntype 128)
-- Trash: 3x Cyanic Crab  (groupid 2), 3x Damask Crab (groupid 3)
-----------------------------------
local walkOfEchoesID = zones[xi.zone.WALK_OF_ECHOES]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.WALK_OF_ECHOES,
    battlefieldId = xi.battlefield.id.FIRST_WALK,
    maxPlayers    = 18,
    levelCap      = 30,
    timeLimit     = utils.minutes(30),
    index         = 1,
    area          = 1,
    entryNpc      = 'Dungeon Master',
    exitNpc       = 'Walk_Exit',
    canLoseExp    = false,
    allowTrusts   = false,
})

-- Defeat all 3 Caldera Crabs to win.
content:addEssentialMobs({ 'Caldera_Crab' })

content.loot =
{
    -- Gil reward
    {
        { itemId = xi.item.GIL, weight = 10000, amount = 2000 },
    },

    -- Consumables (2 items)
    {
        quantity = 2,
        { itemId = xi.item.NONE,              weight = 3000 },
        { itemId = xi.item.HI_POTION,         weight = 2500 },
        { itemId = xi.item.HI_ETHER,          weight = 2500 },
        { itemId = xi.item.POTION_P3,         weight = 1000 },
        { itemId = xi.item.ETHER_P1,          weight = 1000 },
    },

    -- Crafting materials
    {
        quantity = 1,
        { itemId = xi.item.NONE,                   weight = 5000 },
        { itemId = xi.item.SHELL_POWDER,            weight = 1500 },
        { itemId = xi.item.CRAB_SHELL,              weight = 1500 },
        { itemId = xi.item.ROCK_SALT,               weight = 1000 },
        { itemId = xi.item.HANDFUL_OF_FISH_SCALES,  weight = 1000 },
    },
}

return content:register()
