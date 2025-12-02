-----------------------------------
-- Birds of a Feather
-- Waughroon Shrine BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.BIRDS_OF_A_FEATHER,
    maxPlayers       = 3,
    levelCap         = 30,
    timeLimit        = utils.minutes(15),
    index            = 9,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Macha', 'Neman' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 1000, amount = 3000 },
    },

    {
        { itemId = xi.item.BIRD_FEATHER,           weight = 1000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight = 500 },
        { itemId = xi.item.BIRD_EGG,               weight = 250 },
        { itemId = xi.item.BIRD_FEATHER,           weight = 250 },
    },

    {
        quantity = 2,
        { itemId = xi.item.AVATAR_BELT,            weight =  25 },
        { itemId = xi.item.AXE_BELT,               weight =  25 },
        { itemId = xi.item.CESTUS_BELT,            weight =  25 },
        { itemId = xi.item.DAGGER_BELT,            weight =  25 },
        { itemId = xi.item.GUN_BELT,               weight =  25 },
        { itemId = xi.item.KATANA_OBI,             weight =  25 },
        { itemId = xi.item.LANCE_BELT,             weight =  25 },
        { itemId = xi.item.MACE_BELT,              weight =  25 },
        { itemId = xi.item.PICK_BELT,              weight =  25 },
        { itemId = xi.item.RAPIER_BELT,            weight =  25 },
        { itemId = xi.item.SARASHI,                weight =  25 },
        { itemId = xi.item.SCYTHE_BELT,            weight =  25 },
        { itemId = xi.item.SHIELD_BELT,            weight =  25 },
        { itemId = xi.item.SONG_BELT,              weight =  25 },
        { itemId = xi.item.STAFF_BELT,             weight =  25 },
        { itemId = xi.item.ASHIGARU_EARRING,       weight =  25 },
        { itemId = xi.item.BEATERS_EARRING,        weight =  25 },
        { itemId = xi.item.ESQUIRES_EARRING,       weight =  25 },
        { itemId = xi.item.GENIN_EARRING,          weight =  25 },
        { itemId = xi.item.HEALERS_EARRING,        weight =  25 },
        { itemId = xi.item.KILLER_EARRING,         weight =  25 },
        { itemId = xi.item.MAGICIANS_EARRING,      weight =  25 },
        { itemId = xi.item.MERCENARYS_EARRING,     weight =  25 },
        { itemId = xi.item.PILFERERS_EARRING,      weight =  25 },
        { itemId = xi.item.SINGERS_EARRING,        weight =  25 },
        { itemId = xi.item.TRIMMERS_EARRING,       weight =  25 },
        { itemId = xi.item.WARLOCKS_EARRING,       weight =  25 },
        { itemId = xi.item.WIZARDS_EARRING,        weight =  25 },
        { itemId = xi.item.WRESTLERS_EARRING,      weight =  25 },
        { itemId = xi.item.WYVERN_EARRING,         weight =  25 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,      weight =  20 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,    weight =  20 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =  20 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =  20 },
        { itemId = xi.item.IRON_INGOT,             weight =  20 },
        { itemId = xi.item.STEEL_INGOT,            weight =  20 },
        { itemId = xi.item.SILVER_INGOT,           weight =  20 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight =  20 },
        { itemId = xi.item.CHESTNUT_LOG,           weight =  20 },
        { itemId = xi.item.ELM_LOG,                weight =  20 },
        { itemId = xi.item.SARDONYX,               weight =   5 },
        { itemId = xi.item.AMBER_STONE,            weight =   5 },
        { itemId = xi.item.LAPIS_LAZULI,           weight =   5 },
        { itemId = xi.item.TOURMALINE,             weight =   5 },
        { itemId = xi.item.CLEAR_TOPAZ,            weight =   5 },
        { itemId = xi.item.AMETHYST,               weight =   5 },
        { itemId = xi.item.LIGHT_OPAL,             weight =   5 },
        { itemId = xi.item.ONYX,                   weight =   5 },
        { itemId = xi.item.HI_ETHER,               weight =  10 },
    },

    {
        { itemId = xi.item.HORN_QUIVER,            weight = 225 },
        { itemId = xi.item.SCORPION_QUIVER,        weight = 225 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 200 },
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 100 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 100 },
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 100 },
        { itemId = xi.item.HI_POTION,              weight =  50 },
    },
}

return content:register()
