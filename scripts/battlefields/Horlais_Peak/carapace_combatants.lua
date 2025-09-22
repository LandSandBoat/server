-----------------------------------
-- Carapace Combatants
-- Horlais Peak BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.CARAPACE_COMBATANTS,
    maxPlayers       = 3,
    levelCap         = 30,
    timeLimit        = utils.minutes(15),
    index            = 8,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Pilwiz', 'Bisan' })

content.loot =
{
    {
        { itemId = xi.item.BEETLE_JAW, weight = 1000 }, -- beetle_jaw
    },

    {
        { itemId = xi.item.BEETLE_SHELL, weight = 1000 }, -- beetle_shell
    },

    {
        { itemId = xi.item.NONE,        weight = 250 }, -- nothing
        { itemId = xi.item.KATANA_OBI,  weight = 150 }, -- katana_obi
        { itemId = xi.item.STAFF_BELT,  weight = 150 }, -- staff_belt
        { itemId = xi.item.SONG_BELT,   weight = 150 }, -- song_belt
        { itemId = xi.item.CESTUS_BELT, weight = 150 }, -- cestus_belt
        { itemId = xi.item.PICK_BELT,   weight = 150 }, -- pick_belt
    },

    {
        { itemId = xi.item.NONE,              weight = 125 }, -- nothing
        { itemId = xi.item.GENIN_EARRING,     weight = 125 }, -- genin_earring
        { itemId = xi.item.MAGICIANS_EARRING, weight = 125 }, -- magicians_earring
        { itemId = xi.item.PILFERERS_EARRING, weight = 125 }, -- pilferers_earring
        { itemId = xi.item.WARLOCKS_EARRING,  weight = 125 }, -- warlocks_earring
        { itemId = xi.item.WRESTLERS_EARRING, weight = 125 }, -- wrestlers_earring
        { itemId = xi.item.WYVERN_EARRING,    weight = 125 }, -- wyvern_earring
        { itemId = xi.item.KILLER_EARRING,    weight = 125 }, -- killer_earring
    },

    {
        { itemId = xi.item.NONE,                   weight = 160 }, -- nothing
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = 140 }, -- chunk_of_darksteel_ore
        { itemId = xi.item.MYTHRIL_INGOT,          weight = 140 }, -- mythril_ingot
        { itemId = xi.item.SILVER_INGOT,           weight = 140 }, -- silver_ingot
        { itemId = xi.item.STEEL_INGOT,            weight = 140 }, -- steel_ingot
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight = 140 }, -- chunk_of_mythril_ore
        { itemId = xi.item.SARDONYX,               weight = 140 }, -- sardonyx
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 }, -- nothing
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 125 }, -- scroll_of_dispel
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 125 }, -- scroll_of_utsusemi_ni
        { itemId = xi.item.SCROLL_OF_FIRE_II,      weight = 125 }, -- scroll_of_fire_ii
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 125 }, -- scroll_of_magic_finale
        { itemId = xi.item.SCROLL_OF_ABSORB_AGI,   weight = 125 }, -- scroll_of_absorb-agi
        { itemId = xi.item.SCROLL_OF_ABSORB_INT,   weight = 125 }, -- scroll_of_absorb-int
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,               weight = 500 }, -- nothing
        { itemId = xi.item.JUG_OF_SCARLET_SAP, weight = 500 }, -- jug_of_scarlet_sap
    },

    {
        { itemId = xi.item.NONE,     weight = 900 }, -- nothing
        { itemId = xi.item.HI_ETHER, weight = 100 }, -- hi-ether
    },
}

return content:register()
