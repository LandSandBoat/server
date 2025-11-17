-----------------------------------
-- Creeping Doom
-- Balga's Dais BCNM30, Sky Orb
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.CREEPING_DOOM,
    maxPlayers       = 3,
    levelCap         = 30,
    timeLimit        = utils.minutes(15),
    index            = 8,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Bitoso' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                     weight = 1000, amount = 3000 },
    },

    {
        { itemId = xi.item.SPOOL_OF_SILK_THREAD,    weight = 1000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                    weight = 500 },
        { itemId = xi.item.SPOOL_OF_SILK_THREAD,    weight = 500 },
    },

    {
        quantity = 2,
        { itemId = xi.item.ASHIGARU_EARRING,        weight =  50 },
        { itemId = xi.item.BEATERS_EARRING,         weight =  50 },
        { itemId = xi.item.ESQUIRES_EARRING,        weight =  50 },
        { itemId = xi.item.GENIN_EARRING,           weight =  50 },
        { itemId = xi.item.HEALERS_EARRING,         weight =  50 },
        { itemId = xi.item.KILLER_EARRING,          weight =  50 },
        { itemId = xi.item.MAGICIANS_EARRING,       weight =  50 },
        { itemId = xi.item.MERCENARYS_EARRING,      weight =  50 },
        { itemId = xi.item.PILFERERS_EARRING,       weight =  50 },
        { itemId = xi.item.SINGERS_EARRING,         weight =  50 },
        { itemId = xi.item.TRIMMERS_EARRING,        weight =  50 },
        { itemId = xi.item.WARLOCKS_EARRING,        weight =  50 },
        { itemId = xi.item.WRESTLERS_EARRING,       weight =  50 },
        { itemId = xi.item.WIZARDS_EARRING,         weight =  50 },
        { itemId = xi.item.WYVERN_EARRING,          weight =  50 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,       weight =  20 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,     weight =  20 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight =  20 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =  20 },
        { itemId = xi.item.IRON_INGOT,              weight =  20 },
        { itemId = xi.item.STEEL_INGOT,             weight =  20 },
        { itemId = xi.item.SILVER_INGOT,            weight =  20 },
        { itemId = xi.item.MYTHRIL_INGOT,           weight =  20 },
        { itemId = xi.item.CHESTNUT_LOG,            weight =  20 },
        { itemId = xi.item.ELM_LOG,                 weight =  20 },
        { itemId = xi.item.SARDONYX,                weight =   5 },
        { itemId = xi.item.AMBER_STONE,             weight =   5 },
        { itemId = xi.item.LAPIS_LAZULI,            weight =   5 },
        { itemId = xi.item.TOURMALINE,              weight =   5 },
        { itemId = xi.item.CLEAR_TOPAZ,             weight =   5 },
        { itemId = xi.item.AMETHYST,                weight =   5 },
        { itemId = xi.item.LIGHT_OPAL,              weight =   5 },
        { itemId = xi.item.ONYX,                    weight =   5 },
        { itemId = xi.item.HI_ETHER,                weight =  10 },
    },

    {
        { itemId = xi.item.SHEET_OF_BAST_PARCHMENT, weight = 450 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE,  weight = 200 },
        { itemId = xi.item.SCROLL_OF_ERASE,         weight = 100 },
        { itemId = xi.item.SCROLL_OF_DISPEL,        weight = 100 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,   weight = 100 },
        { itemId = xi.item.HI_POTION,               weight =  50 },
    },
}

return content:register()
