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

content.groups =
{
    {
        mobs = { 'Time_Bomb' },

        allDeath = function(battlefield, mob)
            -- Check to see if the bomb died from self-destruct, if not, we win.
            if battlefield:getLocalVar('timeBombExploded') ~= 1 then
                content:handleAllMonstersDefeated(battlefield, mob)
            end
        end,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                      weight = 10000, amount = 12000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.PINCH_OF_BOMB_ASH,        weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                     weight =  5000 },
        { itemId = xi.item.BOMB_ARM,                 weight =  5000 },
    },

    {
        { itemId = xi.item.KAGEBOSHI,                weight =  5000 },
        { itemId = xi.item.ODENTA,                   weight =  5000 },
    },

    {
        { itemId = xi.item.OCEAN_BELT,               weight =  2000 },
        { itemId = xi.item.FOREST_BELT,              weight =  2000 },
        { itemId = xi.item.STEPPE_BELT,              weight =  2000 },
        { itemId = xi.item.JUNGLE_BELT,              weight =  2000 },
        { itemId = xi.item.DESERT_BELT,              weight =  2000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.MAHOGANY_LOG,             weight =   400 },
        { itemId = xi.item.EBONY_LOG,                weight =   400 },
        { itemId = xi.item.PETRIFIED_LOG,            weight =   400 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =   400 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight =   400 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =   400 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =   400 },
        { itemId = xi.item.MYTHRIL_INGOT,            weight =   400 },
        { itemId = xi.item.GOLD_INGOT,               weight =   400 },
        { itemId = xi.item.DARKSTEEL_INGOT,          weight =   400 },
        { itemId = xi.item.PLATINUM_INGOT,           weight =   400 },
        { itemId = xi.item.RAM_HORN,                 weight =   400 },
        { itemId = xi.item.CORAL_FRAGMENT,           weight =   400 },
        { itemId = xi.item.DEMON_HORN,               weight =   400 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =   400 },
        { itemId = xi.item.RAM_SKIN,                 weight =   400 },
        { itemId = xi.item.MANTICORE_HIDE,           weight =   400 },
        { itemId = xi.item.WYVERN_SKIN,              weight =   400 },
        { itemId = xi.item.SCROLL_OF_FREEZE,         weight =   400 },
        { itemId = xi.item.SCROLL_OF_QUAKE,          weight =   400 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,       weight =   400 },
        { itemId = xi.item.SCROLL_OF_REGEN_III,      weight =   400 },
        { itemId = xi.item.FIRE_SPIRIT_PACT,         weight =   400 },
        { itemId = xi.item.LIGHT_SPIRIT_PACT,        weight =   400 },
        { itemId = xi.item.RERAISER,                 weight =   200 },
        { itemId = xi.item.VILE_ELIXIR,              weight =   200 },
    },
}

return content:register()
