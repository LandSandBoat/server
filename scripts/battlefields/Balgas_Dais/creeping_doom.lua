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
        { itemId = xi.item.SPOOL_OF_SILK_THREAD, weight = 1000 }, -- spool_of_silk_thread
    },

    {
        { itemId = xi.item.GIL, weight = 1000, amount = 3000 }, -- gil
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                 weight = 700 }, -- nothing
        { itemId = xi.item.SPOOL_OF_SILK_THREAD, weight = 300 }, -- spool_of_silk_thread
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,               weight = 300 }, -- nothing
        { itemId = xi.item.SINGERS_EARRING,    weight =  40 }, -- singers_earring
        { itemId = xi.item.ASHIGARU_EARRING,   weight =  50 }, -- ashigaru_earring
        { itemId = xi.item.MAGICIANS_EARRING,  weight =  50 }, -- magicians_earring
        { itemId = xi.item.WARLOCKS_EARRING,   weight =  50 }, -- warlocks_earring
        { itemId = xi.item.HEALERS_EARRING,    weight =  40 }, -- healers_earring
        { itemId = xi.item.ESQUIRES_EARRING,   weight =  45 }, -- esquires_earring
        { itemId = xi.item.WIZARDS_EARRING,    weight =  50 }, -- wizards_earring
        { itemId = xi.item.WYVERN_EARRING,     weight =  40 }, -- wyvern_earring
        { itemId = xi.item.MERCENARYS_EARRING, weight =  50 }, -- mercenarys_earring
        { itemId = xi.item.KILLER_EARRING,     weight =  45 }, -- killer_earring
        { itemId = xi.item.WRESTLERS_EARRING,  weight =  45 }, -- wrestlers_earring
        { itemId = xi.item.GENIN_EARRING,      weight =  50 }, -- genin_earring
        { itemId = xi.item.BEATERS_EARRING,    weight =  50 }, -- beaters_earring
        { itemId = xi.item.PILFERERS_EARRING,  weight =  45 }, -- pilferers_earring
        { itemId = xi.item.TRIMMERS_EARRING,   weight =  50 }, -- trimmers_earring
    },

    {
        { itemId = xi.item.NONE,                    weight = 500 }, -- nothing
        { itemId = xi.item.SHEET_OF_BAST_PARCHMENT, weight = 400 }, -- sheet_of_bast_parchment
        { itemId = xi.item.HI_POTION,               weight = 100 }, -- hi-potion
    },

    {
        { itemId = xi.item.NONE,         weight = 500 }, -- nothing
        { itemId = xi.item.CHESTNUT_LOG, weight = 250 }, -- chestnut_log
        { itemId = xi.item.HI_ETHER,     weight = 250 }, -- hi-ether
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 }, -- nothing
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 150 }, -- scroll_of_erase
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 200 }, -- scroll_of_dispel
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 250 }, -- scroll_of_magic_finale
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 150 }, -- scroll_of_utsusemi_ni
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight = 300 }, -- nothing
        { itemId = xi.item.AMBER_STONE,            weight =  50 }, -- amber_stone
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =  50 }, -- chunk_of_darksteel_ore
        { itemId = xi.item.ELM_LOG,                weight =  50 }, -- elm_log
        { itemId = xi.item.IRON_INGOT,             weight =  50 }, -- iron_ingot
        { itemId = xi.item.CHUNK_OF_IRON_ORE,      weight =  50 }, -- chunk_of_iron_ore
        { itemId = xi.item.LAPIS_LAZULI,           weight =  50 }, -- lapis_lazuli
        { itemId = xi.item.MYTHRIL_INGOT,          weight =  50 }, -- mythril_ingot
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =  50 }, -- chunk_of_mythril_ore
        { itemId = xi.item.ONYX,                   weight =  50 }, -- onyx
        { itemId = xi.item.SARDONYX,               weight =  50 }, -- sardonyx
        { itemId = xi.item.SILVER_INGOT,           weight =  50 }, -- silver_ingot
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,    weight =  50 }, -- chunk_of_silver_ore
        { itemId = xi.item.STEEL_INGOT,            weight =  50 }, -- steel_ingot
        { itemId = xi.item.TOURMALINE,             weight =  50 }, -- tourmaline
        { itemId = xi.item.LIGHT_OPAL,             weight =  50 }, -- light opal
    },
}

return content:register()
