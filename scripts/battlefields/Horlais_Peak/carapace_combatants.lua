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
        { item = xi.item.BEETLE_JAW, weight = 1000 }, -- beetle_jaw
    },

    {
        { item = xi.item.BEETLE_SHELL, weight = 1000 }, -- beetle_shell
    },

    {
        { item = xi.item.NONE,        weight = 250 }, -- nothing
        { item = xi.item.KATANA_OBI,  weight = 150 }, -- katana_obi
        { item = xi.item.STAFF_BELT,  weight = 150 }, -- staff_belt
        { item = xi.item.SONG_BELT,   weight = 150 }, -- song_belt
        { item = xi.item.CESTUS_BELT, weight = 150 }, -- cestus_belt
        { item = xi.item.PICK_BELT,   weight = 150 }, -- pick_belt
    },

    {
        { item = xi.item.NONE,              weight = 125 }, -- nothing
        { item = xi.item.GENIN_EARRING,     weight = 125 }, -- genin_earring
        { item = xi.item.MAGICIANS_EARRING, weight = 125 }, -- magicians_earring
        { item = xi.item.PILFERERS_EARRING, weight = 125 }, -- pilferers_earring
        { item = xi.item.WARLOCKS_EARRING,  weight = 125 }, -- warlocks_earring
        { item = xi.item.WRESTLERS_EARRING, weight = 125 }, -- wrestlers_earring
        { item = xi.item.WYVERN_EARRING,    weight = 125 }, -- wyvern_earring
        { item = xi.item.KILLER_EARRING,    weight = 125 }, -- killer_earring
    },

    {
        { item = xi.item.NONE,                   weight = 160 }, -- nothing
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = 140 }, -- chunk_of_darksteel_ore
        { item = xi.item.MYTHRIL_INGOT,          weight = 140 }, -- mythril_ingot
        { item = xi.item.SILVER_INGOT,           weight = 140 }, -- silver_ingot
        { item = xi.item.STEEL_INGOT,            weight = 140 }, -- steel_ingot
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight = 140 }, -- chunk_of_mythril_ore
        { item = xi.item.SARDONYX,               weight = 140 }, -- sardonyx
    },

    {
        { item = xi.item.NONE,                   weight = 250 }, -- nothing
        { item = xi.item.SCROLL_OF_DISPEL,       weight = 125 }, -- scroll_of_dispel
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 125 }, -- scroll_of_utsusemi_ni
        { item = xi.item.SCROLL_OF_FIRE_II,      weight = 125 }, -- scroll_of_fire_ii
        { item = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 125 }, -- scroll_of_magic_finale
        { item = xi.item.SCROLL_OF_ABSORB_AGI,   weight = 125 }, -- scroll_of_absorb-agi
        { item = xi.item.SCROLL_OF_ABSORB_INT,   weight = 125 }, -- scroll_of_absorb-int
    },

    {
        quantity = 2,
        { item = xi.item.NONE,               weight = 500 }, -- nothing
        { item = xi.item.JUG_OF_SCARLET_SAP, weight = 500 }, -- jug_of_scarlet_sap
    },

    {
        { item = xi.item.NONE,     weight = 900 }, -- nothing
        { item = xi.item.HI_ETHER, weight = 100 }, -- hi-ether
    },
}

return content:register()
