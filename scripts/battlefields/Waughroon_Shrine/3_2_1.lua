-----------------------------------
-- 3, 2, 1...
-- Waughroon Shrine BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.THREE_TWO_ONE,
    maxPlayers       = 6,
    levelCap         = 50,
    timeLimit        = utils.minutes(30),
    index            = 5,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Time_Bomb' })

content.loot =
{
    {
        { item = xi.item.KAGEBOSHI, weight = 500 }, -- kageboshi
        { item = xi.item.ODENTA,    weight = 500 }, -- odenta
    },

    {
        { item = xi.item.OCEAN_BELT,  weight = 200 }, -- ocean_belt
        { item = xi.item.FOREST_BELT, weight = 200 }, -- forest_belt
        { item = xi.item.STEPPE_BELT, weight = 200 }, -- steppe_belt
        { item = xi.item.JUNGLE_BELT, weight = 200 }, -- jungle_belt
        { item = xi.item.DESERT_BELT, weight = 200 }, -- desert_belt
    },

    {
        { item = xi.item.NONE,                weight = 250 }, -- nothing
        { item = xi.item.SCROLL_OF_FREEZE,    weight = 125 }, -- scroll_of_freeze
        { item = xi.item.SCROLL_OF_QUAKE,     weight = 125 }, -- scroll_of_quake
        { item = xi.item.SCROLL_OF_RAISE_II,  weight = 125 }, -- scroll_of_raise_ii
        { item = xi.item.SCROLL_OF_REGEN_III, weight = 125 }, -- scroll_of_regen_iii
        { item = xi.item.FIRE_SPIRIT_PACT,    weight = 125 }, -- fire_spirit_pact
        { item = xi.item.LIGHT_SPIRIT_PACT,   weight = 125 }, -- light_spirit_pact
    },

    {
        { item = xi.item.NONE,          weight = 800 }, -- nothing
        { item = xi.item.PETRIFIED_LOG, weight = 200 }, -- petrified_log
    },
}

return content:register()
