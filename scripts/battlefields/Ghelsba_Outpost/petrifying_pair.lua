-----------------------------------
-- Petrifying Pair
-- Ghelsba Outpost BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local ghelsbaID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.GHELSBA_OUTPOST,
    battlefieldId    = xi.battlefield.id.PETRIFYING_PAIR,
    maxPlayers       = 3,
    levelCap         = 30,
    timeLimit        = utils.minutes(15),
    index            = 3,
    area             = 1,
    entryNpc         = 'Hut_Door',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = ghelsbaID.text.A_CRACK_HAS_FORMED, wornMessage = ghelsbaID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        ghelsbaID.mob.KALAMAINU + 2,
    },
})

content:addEssentialMobs({ 'Kalamainu', 'Kilioa' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                       weight = 1000, amount = 3000 }, -- gil
    },

    {
        { itemId = xi.item.LIZARD_SKIN,               weight = 1000 },
    },

    {
        { itemId = xi.item.NONE,                      weight = 500 },
        { itemId = xi.item.LIZARD_SKIN,               weight = 500 },
    },

    -- TODO : Audit Leaping Boots drop rate.
    {
        { itemId = xi.item.NONE,                      weight = 900 },
        { itemId = xi.item.LEAPING_BOOTS,             weight = 100 },
    },

    {
        quantity = 2,
        { itemId = xi.item.AVATAR_BELT,               weight =  50 },
        { itemId = xi.item.AXE_BELT,                  weight =  50 },
        { itemId = xi.item.CESTUS_BELT,               weight =  50 },
        { itemId = xi.item.DAGGER_BELT,               weight =  50 },
        { itemId = xi.item.GUN_BELT,                  weight =  50 },
        { itemId = xi.item.KATANA_OBI,                weight =  50 },
        { itemId = xi.item.LANCE_BELT,                weight =  50 },
        { itemId = xi.item.MACE_BELT,                 weight =  50 },
        { itemId = xi.item.PICK_BELT,                 weight =  50 },
        { itemId = xi.item.RAPIER_BELT,               weight =  50 },
        { itemId = xi.item.SARASHI,                   weight =  50 },
        { itemId = xi.item.SCYTHE_BELT,               weight =  50 },
        { itemId = xi.item.SHIELD_BELT,               weight =  50 },
        { itemId = xi.item.SONG_BELT,                 weight =  50 },
        { itemId = xi.item.STAFF_BELT,                weight =  50 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,         weight =  20 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,       weight =  20 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,      weight =  20 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,    weight =  20 },
        { itemId = xi.item.IRON_INGOT,                weight =  20 },
        { itemId = xi.item.STEEL_INGOT,               weight =  20 },
        { itemId = xi.item.SILVER_INGOT,              weight =  20 },
        { itemId = xi.item.MYTHRIL_INGOT,             weight =  20 },
        { itemId = xi.item.CHESTNUT_LOG,              weight =  20 },
        { itemId = xi.item.ELM_LOG,                   weight =  20 },
        { itemId = xi.item.SARDONYX,                  weight =   5 },
        { itemId = xi.item.AMBER_STONE,               weight =   5 },
        { itemId = xi.item.LAPIS_LAZULI,              weight =   5 },
        { itemId = xi.item.TOURMALINE,                weight =   5 },
        { itemId = xi.item.CLEAR_TOPAZ,               weight =   5 },
        { itemId = xi.item.AMETHYST,                  weight =   5 },
        { itemId = xi.item.LIGHT_OPAL,                weight =   5 },
        { itemId = xi.item.ONYX,                      weight =   5 },
        { itemId = xi.item.HI_ETHER,                  weight =  10 },
    },

    {
        { itemId = xi.item.JUG_OF_COLD_CARRION_BROTH, weight = 450 },
        { itemId = xi.item.SCROLL_OF_ABSORB_AGI,      weight =  90 },
        { itemId = xi.item.SCROLL_OF_ABSORB_INT,      weight =  90 },
        { itemId = xi.item.SCROLL_OF_ABSORB_VIT,      weight =  90 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE,    weight =  95 },
        { itemId = xi.item.SCROLL_OF_DISPEL,          weight =  45 },
        { itemId = xi.item.SCROLL_OF_ERASE,           weight =  45 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,     weight =  45 },
        { itemId = xi.item.HI_POTION,                 weight =  50 },
    },
}

return content:register()
