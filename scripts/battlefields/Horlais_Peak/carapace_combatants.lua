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
        { itemId = xi.item.BEETLE_JAW,             weight = 1000 },
    },

    {
        { itemId = xi.item.BEETLE_SHELL,           weight = 1000 },
    },

    {
        { itemId = xi.item.AVATAR_BELT,            weight = 71 },
        { itemId = xi.item.AXE_BELT,               weight = 71 },
        { itemId = xi.item.CESTUS_BELT,            weight = 72 },
        { itemId = xi.item.DAGGER_BELT,            weight = 72 },
        { itemId = xi.item.GUN_BELT,               weight = 72 },
        { itemId = xi.item.KATANA_OBI,             weight = 71 },
        { itemId = xi.item.LANCE_BELT,             weight = 71 },
        { itemId = xi.item.SARASHI,                weight = 72 },
        { itemId = xi.item.SCYTHE_BELT,            weight = 72 },
        { itemId = xi.item.SHIELD_BELT,            weight = 72 },
        { itemId = xi.item.SONG_BELT,              weight = 71 },
        { itemId = xi.item.STAFF_BELT,             weight = 71 },
        { itemId = xi.item.PICK_BELT,              weight = 71 },
        { itemId = xi.item.RAPIER_BELT,            weight = 71 },
    },

    {
        { itemId = xi.item.ASHIGARU_EARRING,       weight = 71 },
        { itemId = xi.item.ESQUIRES_EARRING,       weight = 71 },
        { itemId = xi.item.MAGICIANS_EARRING,      weight = 72 },
        { itemId = xi.item.MERCENARYS_EARRING,     weight = 72 },
        { itemId = xi.item.PILFERERS_EARRING,      weight = 72 },
        { itemId = xi.item.SINGERS_EARRING,        weight = 71 },
        { itemId = xi.item.TRIMMERS_EARRING,       weight = 71 },
        { itemId = xi.item.WARLOCKS_EARRING,       weight = 72 },
        { itemId = xi.item.WIZARDS_EARRING,        weight = 72 },
        { itemId = xi.item.WRESTLERS_EARRING,      weight = 72 },
        { itemId = xi.item.WYVERN_EARRING,         weight = 71 },
        { itemId = xi.item.BEATERS_EARRING,        weight = 71 },
        { itemId = xi.item.GENIN_EARRING,          weight = 71 },
        { itemId = xi.item.KILLER_EARRING,         weight = 71 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 160 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = 140 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight = 140 },
        { itemId = xi.item.SILVER_INGOT,           weight = 140 },
        { itemId = xi.item.STEEL_INGOT,            weight = 140 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight = 140 },
        { itemId = xi.item.SARDONYX,               weight = 140 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 125 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 125 },
        { itemId = xi.item.SCROLL_OF_FIRE_II,      weight = 125 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 125 },
        { itemId = xi.item.SCROLL_OF_ABSORB_AGI,   weight = 125 },
        { itemId = xi.item.SCROLL_OF_ABSORB_INT,   weight = 125 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight = 500 },
        { itemId = xi.item.JUG_OF_SCARLET_SAP,     weight = 500 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 900 },
        { itemId = xi.item.HI_ETHER,               weight = 100 },
    },
}

return content:register()
