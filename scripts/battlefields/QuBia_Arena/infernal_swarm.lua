-----------------------------------
-- Infernal Swarm
-- Qu'Bia Arena KSNM(30), Atropos Orb
-- !additem 1180
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.INFERNAL_SWARM,
    maxPlayers = 6,
    timeLimit = utils.minutes(30),
    index = 3,
    entryNpc = 'BC_Entrance',
    exitNpc = 'Burning_Circle',
    requiredItems = {
        xi.item.ATROPOS_ORB,
        wearMessage = qubiaID.text.A_CRACK_HAS_FORMED,
        wornMessage = qubiaID.text.ORB_IS_CRACKED,
    },
})

content:addEssentialMobs({ 'Hell_Fly', 'Beelzebub' })

content.loot =
{
    {
        { itemId = xi.item.GIL, weight = 1000, amount = 24000 }, -- Gil
    },

    {
        { itemId = xi.item.PHOENIX_FEATHER, weight = 1000 }, -- Phoenix Feather
    },

    {
        { itemId = xi.item.NONE, weight = 62 }, -- Nothing
        { itemId = xi.item.GUARDIAN_EARRING, weight = 62 }, -- Guardian Earring
        { itemId = xi.item.KAMPFER_EARRING, weight = 62 }, -- Kampfer Earring
        { itemId = xi.item.CONJURERS_EARRING, weight = 62 }, -- Conjurer's Earring
        { itemId = xi.item.SHINOBI_EARRING, weight = 62 }, -- Shinobi Earring
        { itemId = xi.item.TRACKERS_EARRING, weight = 62 }, -- Trackers Earring
        { itemId = xi.item.SORCERERS_EARRING, weight = 62 }, -- Sorcerer's Earring
        { itemId = xi.item.SOLDIERS_EARRING, weight = 62 }, -- Soldier's Earring
        { itemId = xi.item.TAMERS_EARRING, weight = 63 }, -- Tamer's Earring
        { itemId = xi.item.MEDICINE_EARRING, weight = 63 }, -- Medicine Earring
        { itemId = xi.item.DRAKE_EARRING, weight = 63 }, -- Drake Earring
        { itemId = xi.item.FENCERS_EARRING, weight = 63 }, -- Fencer's Earring
        { itemId = xi.item.MINSTRELS_EARRING, weight = 63 }, -- Minstel's Earring
        { itemId = xi.item.ROGUES_EARRING, weight = 63 }, -- Rogue's Earring
        { itemId = xi.item.RONIN_EARRING, weight = 63 }, -- Ronin Earring
        { itemId = xi.item.SLAYERS_EARRING, weight = 63 }, -- Slayer's Earring
    },

    {
        { itemId = xi.item.NONE, weight = 62 }, -- Nothing
        { itemId = xi.item.GUARDIAN_EARRING, weight = 62 }, -- Guardian Earring
        { itemId = xi.item.KAMPFER_EARRING, weight = 62 }, -- Kampfer Earring
        { itemId = xi.item.CONJURERS_EARRING, weight = 62 }, -- Conjurer's Earring
        { itemId = xi.item.SHINOBI_EARRING, weight = 62 }, -- Shinobi Earring
        { itemId = xi.item.TRACKERS_EARRING, weight = 62 }, -- Trackers Earring
        { itemId = xi.item.SORCERERS_EARRING, weight = 62 }, -- Sorcerer's Earring
        { itemId = xi.item.SOLDIERS_EARRING, weight = 62 }, -- Soldier's Earring
        { itemId = xi.item.TAMERS_EARRING, weight = 63 }, -- Tamer's Earring
        { itemId = xi.item.MEDICINE_EARRING, weight = 63 }, -- Medicine Earring
        { itemId = xi.item.DRAKE_EARRING, weight = 63 }, -- Drake Earring
        { itemId = xi.item.FENCERS_EARRING, weight = 63 }, -- Fencer's Earring
        { itemId = xi.item.MINSTRELS_EARRING, weight = 63 }, -- Minstel's Earring
        { itemId = xi.item.ROGUES_EARRING, weight = 63 }, -- Rogue's Earring
        { itemId = xi.item.RONIN_EARRING, weight = 63 }, -- Ronin Earring
        { itemId = xi.item.SLAYERS_EARRING, weight = 63 }, -- Slayer's Earring
    },

    {
        { itemId = xi.item.OCEAN_SASH, weight = 200 }, -- Ocean Sash
        { itemId = xi.item.JUNGLE_SASH, weight = 200 }, -- Jungle Sash
        { itemId = xi.item.STEPPE_SASH, weight = 200 }, -- Steppe Sash
        { itemId = xi.item.DESERT_SASH, weight = 200 }, -- Desert Sash
        { itemId = xi.item.FOREST_SASH, weight = 200 }, -- Forest Sash
    },

    {
        { itemId = xi.item.NONE, weight = 100 }, -- Nothing
        { itemId = xi.item.STAFF_STRAP, weight = 225 }, -- Staff Strap
        { itemId = xi.item.CLAYMORE_GRIP, weight = 225 }, -- Claymore Grip
        { itemId = xi.item.POLE_GRIP, weight = 225 }, -- Pole Grip
        { itemId = xi.item.SPEAR_STRAP, weight = 225 }, -- Spear Strap
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 87 }, -- Vial Of Black Beetle Blood
        { itemId = xi.item.DAMASCUS_INGOT, weight = 14 }, -- Damascus Ingot
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH, weight = 29 }, -- Square Of Damascene Cloth
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER, weight = 43 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.PHILOSOPHERS_STONE, weight = 174 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER, weight = 246 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_RAXA, weight = 159 }, -- Square Of Raxa
    },

    {
        { itemId = xi.item.SCROLL_OF_CURE_V, weight = 50 }, -- Scroll of Cure V
        { itemId = xi.item.SCROLL_OF_SHELL_IV, weight = 50 }, -- Scroll of Shell IV
        { itemId = xi.item.LIGHT_SPIRIT_PACT, weight = 40 }, -- Light Spirit Pact
        { itemId = xi.item.HI_RERAISER, weight = 220 }, -- Hi Reraiser
        { itemId = xi.item.CHUNK_OF_ADAMAN_ORE, weight = 20 }, -- Chunk of Adaman Ore
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight = 25 }, -- Square of Rainbow Cloth
        { itemId = xi.item.PETRIFIED_LOG, weight = 60 }, -- Petrified Log
        { itemId = xi.item.MAHOGANY_LOG, weight = 75 }, -- Mahogany Log
        { itemId = xi.item.CORAL_FRAGMENT, weight = 85 }, -- Coral Fragment
        { itemId = xi.item.DEMON_HORN, weight = 70 }, -- Demon Horn
        { itemId = xi.item.RAM_HORN, weight = 95 }, -- Ram Horn
        { itemId = xi.item.SLAB_OF_GRANITE, weight = 85 }, -- Slab of Granite
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = 100 }, -- Chunk of Darksteel Ore
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE, weight = 25 }, -- Chunk of Platinum Ore
    },
}

return content:register()
