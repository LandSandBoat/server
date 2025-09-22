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
        { itemId = xi.item.LIZARD_SKIN, weight = 1000 }, -- Lizard Skin
    },

    {
        { itemId = xi.item.NONE,          weight = 900 }, -- nothing
        { itemId = xi.item.LEAPING_BOOTS, weight = 100 }, -- leaping_boots
    },

    {
        { itemId = xi.item.KATANA_OBI,   weight =  50 }, -- Katana Obi
        { itemId = xi.item.RAPIER_BELT,  weight =  75 }, -- Rapier Belt
        { itemId = xi.item.SCYTHE_BELT,  weight = 175 }, -- Scythe Belt
        { itemId = xi.item.CHESTNUT_LOG, weight = 175 }, -- Chestnut Log
        { itemId = xi.item.ELM_LOG,      weight = 350 }, -- Elm Log
        { itemId = xi.item.STEEL_INGOT,  weight = 100 }, -- Steel Ingot
    },

    {
        { itemId = xi.item.NONE,         weight = 925 }, -- nothing (50%)
        { itemId = xi.item.KATANA_OBI,   weight =  50 }, -- Katana Obi
        { itemId = xi.item.RAPIER_BELT,  weight =  75 }, -- Rapier Belt
        { itemId = xi.item.SCYTHE_BELT,  weight = 175 }, -- Scythe Belt
        { itemId = xi.item.CHESTNUT_LOG, weight = 175 }, -- Chestnut Log
        { itemId = xi.item.ELM_LOG,      weight = 350 }, -- Elm Log
        { itemId = xi.item.STEEL_INGOT,  weight = 100 }, -- Steel Ingot
    },

    {
        { itemId = xi.item.AVATAR_BELT,          weight = 105 }, -- Avatar Belt
        { itemId = xi.item.PICK_BELT,            weight = 105 }, -- Pick Belt
        { itemId = xi.item.IRON_INGOT,           weight = 131 }, -- Iron Ingot
        { itemId = xi.item.CHUNK_OF_IRON_ORE,    weight = 131 }, -- Chunk Of Iron Ore
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE, weight =  79 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,  weight =  79 }, -- Chunk Of Silver Ore
        { itemId = xi.item.LAPIS_LAZULI,         weight = 131 }, -- Lapis Lazuli
    },

    {
        { itemId = xi.item.JUG_OF_COLD_CARRION_BROTH, weight = 552 }, -- Jug Of Cold Carrion Broth
        { itemId = xi.item.SCROLL_OF_ABSORB_AGI,      weight = 263 }, -- Scroll Of Absorb-agi
        { itemId = xi.item.SCROLL_OF_ABSORB_INT,      weight = 210 }, -- Scroll Of Absorb-int
        { itemId = xi.item.SCROLL_OF_ABSORB_VIT,      weight = 289 }, -- Scroll Of Absorb-vit
        { itemId = xi.item.SCROLL_OF_DISPEL,          weight = 105 }, -- Scroll Of Dispel
        { itemId = xi.item.SCROLL_OF_ERASE,           weight =  79 }, -- Scroll Of Erase
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE,    weight = 421 }, -- Scroll Of Magic Finale
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,     weight =  79 }, -- Scroll Of Utsusemi Ni
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight = 736 }, -- nothing (25%)
        { itemId = xi.item.AXE_BELT,               weight = 200 }, -- Axe Belt
        { itemId = xi.item.CESTUS_BELT,            weight = 125 }, -- Cestus Belt
        { itemId = xi.item.CLEAR_TOPAZ,            weight =  10 }, -- Clear Topaz
        { itemId = xi.item.DAGGER_BELT,            weight =  75 }, -- Dagger Belt
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = 100 }, -- Darksteel Ore
        { itemId = xi.item.GUN_BELT,               weight =  25 }, -- Gun Belt
        { itemId = xi.item.HI_ETHER,               weight = 175 }, -- Hi-ether
        { itemId = xi.item.LANCE_BELT,             weight = 200 }, -- Lance Belt
        { itemId = xi.item.LIGHT_OPAL,             weight =  75 }, -- Light Opal
        { itemId = xi.item.MACE_BELT,              weight = 175 }, -- Mace Belt
        { itemId = xi.item.MYTHRIL_INGOT,          weight = 200 }, -- Mythril Ingot
        { itemId = xi.item.ONYX,                   weight =  25 }, -- Onyx
        { itemId = xi.item.SARASHI,                weight = 250 }, -- Sarashi
        { itemId = xi.item.SHIELD_BELT,            weight = 100 }, -- Shield Belt
        { itemId = xi.item.SONG_BELT,              weight = 100 }, -- Song Belt
        { itemId = xi.item.STAFF_BELT,             weight = 150 }, -- Staff Belt
        { itemId = xi.item.SILVER_INGOT,           weight = 100 }, -- Silver Ingot
        { itemId = xi.item.TOURMALINE,             weight = 125 }, -- Tourmaline
    },
}

return content:register()
