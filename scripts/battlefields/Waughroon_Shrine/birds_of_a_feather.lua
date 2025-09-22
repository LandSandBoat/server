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
        { itemId = xi.item.BIRD_FEATHER, weight = 1000 }, -- Bird Feather
    },

    {
        { itemId = xi.item.ASHIGARU_EARRING,   weight = 125 }, -- Ashigaru Earring
        { itemId = xi.item.TRIMMERS_EARRING,   weight = 125 }, -- Trimmers Earring
        { itemId = xi.item.BEATERS_EARRING,    weight = 125 }, -- Beaters Earring
        { itemId = xi.item.HEALERS_EARRING,    weight = 125 }, -- Healers Earring
        { itemId = xi.item.MERCENARYS_EARRING, weight = 125 }, -- Mercenarys Earring
        { itemId = xi.item.SINGERS_EARRING,    weight = 125 }, -- Singers Earring
        { itemId = xi.item.WIZARDS_EARRING,    weight = 125 }, -- Wizards Earring
        { itemId = xi.item.WRESTLERS_EARRING,  weight = 125 }, -- Wrestlers Earring
    },

    {
        { itemId = xi.item.NONE,        weight = 125 }, -- nothing
        { itemId = xi.item.AVATAR_BELT, weight = 125 }, -- Avatar Belt
        { itemId = xi.item.DAGGER_BELT, weight = 125 }, -- Dagger Belt
        { itemId = xi.item.LANCE_BELT,  weight = 125 }, -- Lance Belt
        { itemId = xi.item.RAPIER_BELT, weight = 125 }, -- Rapier Belt
        { itemId = xi.item.SARASHI,     weight = 125 }, -- Sarashi
        { itemId = xi.item.SCYTHE_BELT, weight = 125 }, -- Scythe Belt
        { itemId = xi.item.SHIELD_BELT, weight = 125 }, -- Shield Belt
    },

    {
        { itemId = xi.item.NONE,                   weight = 500 }, -- nothing
        { itemId = xi.item.SCROLL_OF_DISPEL,       weight = 125 }, -- Scroll Of Dispel
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 125 }, -- Scroll Of Erase
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 125 }, -- Scroll Of Magic Finale
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 125 }, -- Scroll Of Utsusemi Ni
    },

    {
        { itemId = xi.item.NONE,         weight = 136 }, -- nothing
        { itemId = xi.item.BIRD_EGG,     weight = 125 }, -- Bird Egg
        { itemId = xi.item.BIRD_FEATHER, weight =  50 }, -- Bird Feather
        { itemId = xi.item.CHESTNUT_LOG, weight = 125 }, -- Chestnut Log
        { itemId = xi.item.ELM_LOG,      weight = 188 }, -- Elm Log
        { itemId = xi.item.HI_ETHER,     weight =  63 }, -- Hi-ether
        { itemId = xi.item.HORN_QUIVER,  weight = 313 }, -- Horn Quiver
    },

    {
        { itemId = xi.item.NONE,                 weight = 123 }, -- nothing
        { itemId = xi.item.IRON_INGOT,           weight =  63 }, -- Iron Ingot
        { itemId = xi.item.LAPIS_LAZULI,         weight = 125 }, -- Lapis Lazuli
        { itemId = xi.item.LIGHT_OPAL,           weight = 125 }, -- Light Opal
        { itemId = xi.item.MYTHRIL_INGOT,        weight =  63 }, -- Mythril Ingot
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE, weight =  63 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.ONYX,                 weight = 250 }, -- Onyx
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,  weight =  63 }, -- Chunk Of Silver Ore
        { itemId = xi.item.SILVER_INGOT,         weight = 125 }, -- Silver Ingot
    },
}

return content:register()
