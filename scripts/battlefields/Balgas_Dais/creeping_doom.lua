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
        { item = xi.item.SPOOL_OF_SILK_THREAD, weight = 1000 }, -- spool_of_silk_thread
    },

    {
        { item = xi.item.GIL, weight = 1000, amount = 3000 }, -- gil
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                 weight = 700 }, -- nothing
        { item = xi.item.SPOOL_OF_SILK_THREAD, weight = 300 }, -- spool_of_silk_thread
    },

    {
        quantity = 2,
        { item = xi.item.NONE,               weight = 300 }, -- nothing
        { item = xi.item.SINGERS_EARRING,    weight =  40 }, -- singers_earring
        { item = xi.item.ASHIGARU_EARRING,   weight =  50 }, -- ashigaru_earring
        { item = xi.item.MAGICIANS_EARRING,  weight =  50 }, -- magicians_earring
        { item = xi.item.WARLOCKS_EARRING,   weight =  50 }, -- warlocks_earring
        { item = xi.item.HEALERS_EARRING,    weight =  40 }, -- healers_earring
        { item = xi.item.ESQUIRES_EARRING,   weight =  45 }, -- esquires_earring
        { item = xi.item.WIZARDS_EARRING,    weight =  50 }, -- wizards_earring
        { item = xi.item.WYVERN_EARRING,     weight =  40 }, -- wyvern_earring
        { item = xi.item.MERCENARYS_EARRING, weight =  50 }, -- mercenarys_earring
        { item = xi.item.KILLER_EARRING,     weight =  45 }, -- killer_earring
        { item = xi.item.WRESTLERS_EARRING,  weight =  45 }, -- wrestlers_earring
        { item = xi.item.GENIN_EARRING,      weight =  50 }, -- genin_earring
        { item = xi.item.BEATERS_EARRING,    weight =  50 }, -- beaters_earring
        { item = xi.item.PILFERERS_EARRING,  weight =  45 }, -- pilferers_earring
        { item = xi.item.TRIMMERS_EARRING,   weight =  50 }, -- trimmers_earring
    },

    {
        { item = xi.item.NONE,                    weight = 500 }, -- nothing
        { item = xi.item.SHEET_OF_BAST_PARCHMENT, weight = 400 }, -- sheet_of_bast_parchment
        { item = xi.item.HI_POTION,               weight = 100 }, -- hi-potion
    },

    {
        { item = xi.item.NONE,         weight = 500 }, -- nothing
        { item = xi.item.CHESTNUT_LOG, weight = 250 }, -- chestnut_log
        { item = xi.item.HI_ETHER,     weight = 250 }, -- hi-ether
    },

    {
        { item = xi.item.NONE,                   weight = 250 }, -- nothing
        { item = xi.item.SCROLL_OF_ERASE,        weight = 150 }, -- scroll_of_erase
        { item = xi.item.SCROLL_OF_DISPEL,       weight = 200 }, -- scroll_of_dispel
        { item = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 250 }, -- scroll_of_magic_finale
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 150 }, -- scroll_of_utsusemi_ni
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                   weight = 300 }, -- nothing
        { item = xi.item.AMBER_STONE,            weight =  50 }, -- amber_stone
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =  50 }, -- chunk_of_darksteel_ore
        { item = xi.item.ELM_LOG,                weight =  50 }, -- elm_log
        { item = xi.item.IRON_INGOT,             weight =  50 }, -- iron_ingot
        { item = xi.item.CHUNK_OF_IRON_ORE,      weight =  50 }, -- chunk_of_iron_ore
        { item = xi.item.LAPIS_LAZULI,           weight =  50 }, -- lapis_lazuli
        { item = xi.item.MYTHRIL_INGOT,          weight =  50 }, -- mythril_ingot
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =  50 }, -- chunk_of_mythril_ore
        { item = xi.item.ONYX,                   weight =  50 }, -- onyx
        { item = xi.item.SARDONYX,               weight =  50 }, -- sardonyx
        { item = xi.item.SILVER_INGOT,           weight =  50 }, -- silver_ingot
        { item = xi.item.CHUNK_OF_SILVER_ORE,    weight =  50 }, -- chunk_of_silver_ore
        { item = xi.item.STEEL_INGOT,            weight =  50 }, -- steel_ingot
        { item = xi.item.TOURMALINE,             weight =  50 }, -- tourmaline
        { item = xi.item.LIGHT_OPAL,             weight =  50 }, -- light opal
    },
}

return content:register()
