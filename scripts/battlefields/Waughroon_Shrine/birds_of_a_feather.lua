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
        { item = xi.item.BIRD_FEATHER, weight = 1000 }, -- Bird Feather
    },

    {
        { item = xi.item.ASHIGARU_EARRING,   weight = 125 }, -- Ashigaru Earring
        { item = xi.item.TRIMMERS_EARRING,   weight = 125 }, -- Trimmers Earring
        { item = xi.item.BEATERS_EARRING,    weight = 125 }, -- Beaters Earring
        { item = xi.item.HEALERS_EARRING,    weight = 125 }, -- Healers Earring
        { item = xi.item.MERCENARYS_EARRING, weight = 125 }, -- Mercenarys Earring
        { item = xi.item.SINGERS_EARRING,    weight = 125 }, -- Singers Earring
        { item = xi.item.WIZARDS_EARRING,    weight = 125 }, -- Wizards Earring
        { item = xi.item.WRESTLERS_EARRING,  weight = 125 }, -- Wrestlers Earring
    },

    {
        { item = xi.item.NONE,        weight = 125 }, -- nothing
        { item = xi.item.AVATAR_BELT, weight = 125 }, -- Avatar Belt
        { item = xi.item.DAGGER_BELT, weight = 125 }, -- Dagger Belt
        { item = xi.item.LANCE_BELT,  weight = 125 }, -- Lance Belt
        { item = xi.item.RAPIER_BELT, weight = 125 }, -- Rapier Belt
        { item = xi.item.SARASHI,     weight = 125 }, -- Sarashi
        { item = xi.item.SCYTHE_BELT, weight = 125 }, -- Scythe Belt
        { item = xi.item.SHIELD_BELT, weight = 125 }, -- Shield Belt
    },

    {
        { item = xi.item.NONE,                   weight = 500 }, -- nothing
        { item = xi.item.SCROLL_OF_DISPEL,       weight = 125 }, -- Scroll Of Dispel
        { item = xi.item.SCROLL_OF_ERASE,        weight = 125 }, -- Scroll Of Erase
        { item = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 125 }, -- Scroll Of Magic Finale
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 125 }, -- Scroll Of Utsusemi Ni
    },

    {
        { item = xi.item.NONE,         weight = 136 }, -- nothing
        { item = xi.item.BIRD_EGG,     weight = 125 }, -- Bird Egg
        { item = xi.item.BIRD_FEATHER, weight =  50 }, -- Bird Feather
        { item = xi.item.CHESTNUT_LOG, weight = 125 }, -- Chestnut Log
        { item = xi.item.ELM_LOG,      weight = 188 }, -- Elm Log
        { item = xi.item.HI_ETHER,     weight =  63 }, -- Hi-ether
        { item = xi.item.HORN_QUIVER,  weight = 313 }, -- Horn Quiver
    },

    {
        { item = xi.item.NONE,                 weight = 123 }, -- nothing
        { item = xi.item.IRON_INGOT,           weight =  63 }, -- Iron Ingot
        { item = xi.item.LAPIS_LAZULI,         weight = 125 }, -- Lapis Lazuli
        { item = xi.item.LIGHT_OPAL,           weight = 125 }, -- Light Opal
        { item = xi.item.MYTHRIL_INGOT,        weight =  63 }, -- Mythril Ingot
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE, weight =  63 }, -- Chunk Of Mythril Ore
        { item = xi.item.ONYX,                 weight = 250 }, -- Onyx
        { item = xi.item.CHUNK_OF_SILVER_ORE,  weight =  63 }, -- Chunk Of Silver Ore
        { item = xi.item.SILVER_INGOT,         weight = 125 }, -- Silver Ingot
    },
}

return content:register()
