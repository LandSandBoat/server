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
        { item = xi.item.LIZARD_SKIN, weight = 1000 }, -- Lizard Skin
    },

    {
        { item = xi.item.NONE,          weight = 900 }, -- nothing
        { item = xi.item.LEAPING_BOOTS, weight = 100 }, -- leaping_boots
    },

    {
        { item = xi.item.KATANA_OBI,   weight =  50 }, -- Katana Obi
        { item = xi.item.RAPIER_BELT,  weight =  75 }, -- Rapier Belt
        { item = xi.item.SCYTHE_BELT,  weight = 175 }, -- Scythe Belt
        { item = xi.item.CHESTNUT_LOG, weight = 175 }, -- Chestnut Log
        { item = xi.item.ELM_LOG,      weight = 350 }, -- Elm Log
        { item = xi.item.STEEL_INGOT,  weight = 100 }, -- Steel Ingot
    },

    {
        { item = xi.item.NONE,         weight = 925 }, -- nothing (50%)
        { item = xi.item.KATANA_OBI,   weight =  50 }, -- Katana Obi
        { item = xi.item.RAPIER_BELT,  weight =  75 }, -- Rapier Belt
        { item = xi.item.SCYTHE_BELT,  weight = 175 }, -- Scythe Belt
        { item = xi.item.CHESTNUT_LOG, weight = 175 }, -- Chestnut Log
        { item = xi.item.ELM_LOG,      weight = 350 }, -- Elm Log
        { item = xi.item.STEEL_INGOT,  weight = 100 }, -- Steel Ingot
    },

    {
        { item = xi.item.AVATAR_BELT,          weight = 105 }, -- Avatar Belt
        { item = xi.item.PICK_BELT,            weight = 105 }, -- Pick Belt
        { item = xi.item.IRON_INGOT,           weight = 131 }, -- Iron Ingot
        { item = xi.item.CHUNK_OF_IRON_ORE,    weight = 131 }, -- Chunk Of Iron Ore
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE, weight =  79 }, -- Chunk Of Mythril Ore
        { item = xi.item.CHUNK_OF_SILVER_ORE,  weight =  79 }, -- Chunk Of Silver Ore
        { item = xi.item.LAPIS_LAZULI,         weight = 131 }, -- Lapis Lazuli
    },

    {
        { item = xi.item.JUG_OF_COLD_CARRION_BROTH, weight = 552 }, -- Jug Of Cold Carrion Broth
        { item = xi.item.SCROLL_OF_ABSORB_AGI,      weight = 263 }, -- Scroll Of Absorb-agi
        { item = xi.item.SCROLL_OF_ABSORB_INT,      weight = 210 }, -- Scroll Of Absorb-int
        { item = xi.item.SCROLL_OF_ABSORB_VIT,      weight = 289 }, -- Scroll Of Absorb-vit
        { item = xi.item.SCROLL_OF_DISPEL,          weight = 105 }, -- Scroll Of Dispel
        { item = xi.item.SCROLL_OF_ERASE,           weight =  79 }, -- Scroll Of Erase
        { item = xi.item.SCROLL_OF_MAGIC_FINALE,    weight = 421 }, -- Scroll Of Magic Finale
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI,     weight =  79 }, -- Scroll Of Utsusemi Ni
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                   weight = 736 }, -- nothing (25%)
        { item = xi.item.AXE_BELT,               weight = 200 }, -- Axe Belt
        { item = xi.item.CESTUS_BELT,            weight = 125 }, -- Cestus Belt
        { item = xi.item.CLEAR_TOPAZ,            weight =  10 }, -- Clear Topaz
        { item = xi.item.DAGGER_BELT,            weight =  75 }, -- Dagger Belt
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = 100 }, -- Darksteel Ore
        { item = xi.item.GUN_BELT,               weight =  25 }, -- Gun Belt
        { item = xi.item.HI_ETHER,               weight = 175 }, -- Hi-ether
        { item = xi.item.LANCE_BELT,             weight = 200 }, -- Lance Belt
        { item = xi.item.LIGHT_OPAL,             weight =  75 }, -- Light Opal
        { item = xi.item.MACE_BELT,              weight = 175 }, -- Mace Belt
        { item = xi.item.MYTHRIL_INGOT,          weight = 200 }, -- Mythril Ingot
        { item = xi.item.ONYX,                   weight =  25 }, -- Onyx
        { item = xi.item.SARASHI,                weight = 250 }, -- Sarashi
        { item = xi.item.SHIELD_BELT,            weight = 100 }, -- Shield Belt
        { item = xi.item.SONG_BELT,              weight = 100 }, -- Song Belt
        { item = xi.item.STAFF_BELT,             weight = 150 }, -- Staff Belt
        { item = xi.item.SILVER_INGOT,           weight = 100 }, -- Silver Ingot
        { item = xi.item.TOURMALINE,             weight = 125 }, -- Tourmaline
    },
}

return content:register()
