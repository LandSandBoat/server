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

content.loot = {
    {
        { item = xi.item.PHOENIX_FEATHER, weight = 1000 }, -- Phoenix Feather
    },

    {
        { item = xi.item.NONE, weight = 62 }, -- Nothing
        { item = xi.item.GUARDIAN_EARRING, weight = 62 }, -- Guardian Earring
        { item = xi.item.KAMPFER_EARRING, weight = 62 }, -- Kampfer Earring
        { item = xi.item.CONJURERS_EARRING, weight = 62 }, -- Conjurer's Earring
        { item = xi.item.SHINOBI_EARRING, weight = 62 }, -- Shinobi Earring
        { item = xi.item.TRACKERS_EARRING, weight = 62 }, -- Trackers Earring
        { item = xi.item.SORCERERS_EARRING, weight = 62 }, -- Sorcerer's Earring
        { item = xi.item.SOLDIERS_EARRING, weight = 62 }, -- Soldier's Earring
        { item = xi.item.TAMERS_EARRING, weight = 63 }, -- Tamer's Earring
        { item = xi.item.MEDICINE_EARRING, weight = 63 }, -- Medicine Earring
        { item = xi.item.DRAKE_EARRING, weight = 63 }, -- Drake Earring
        { item = xi.item.FENCERS_EARRING, weight = 63 }, -- Fencer's Earring
        { item = xi.item.MINSTRELS_EARRING, weight = 63 }, -- Minstel's Earring
        { item = xi.item.ROGUES_EARRING, weight = 63 }, -- Rogue's Earring
        { item = xi.item.RONIN_EARRING, weight = 63 }, -- Ronin Earring
        { item = xi.item.SLAYERS_EARRING, weight = 63 }, -- Slayer's Earring
    },

    {
        { item = xi.item.NONE, weight = 62 }, -- Nothing
        { item = xi.item.GUARDIAN_EARRING, weight = 62 }, -- Guardian Earring
        { item = xi.item.KAMPFER_EARRING, weight = 62 }, -- Kampfer Earring
        { item = xi.item.CONJURERS_EARRING, weight = 62 }, -- Conjurer's Earring
        { item = xi.item.SHINOBI_EARRING, weight = 62 }, -- Shinobi Earring
        { item = xi.item.TRACKERS_EARRING, weight = 62 }, -- Trackers Earring
        { item = xi.item.SORCERERS_EARRING, weight = 62 }, -- Sorcerer's Earring
        { item = xi.item.SOLDIERS_EARRING, weight = 62 }, -- Soldier's Earring
        { item = xi.item.TAMERS_EARRING, weight = 63 }, -- Tamer's Earring
        { item = xi.item.MEDICINE_EARRING, weight = 63 }, -- Medicine Earring
        { item = xi.item.DRAKE_EARRING, weight = 63 }, -- Drake Earring
        { item = xi.item.FENCERS_EARRING, weight = 63 }, -- Fencer's Earring
        { item = xi.item.MINSTRELS_EARRING, weight = 63 }, -- Minstel's Earring
        { item = xi.item.ROGUES_EARRING, weight = 63 }, -- Rogue's Earring
        { item = xi.item.RONIN_EARRING, weight = 63 }, -- Ronin Earring
        { item = xi.item.SLAYERS_EARRING, weight = 63 }, -- Slayer's Earring
    },

    {
        { item = xi.item.OCEAN_SASH, weight = 200 }, -- Ocean Sash
        { item = xi.item.JUNGLE_SASH, weight = 200 }, -- Jungle Sash
        { item = xi.item.STEPPE_SASH, weight = 200 }, -- Steppe Sash
        { item = xi.item.DESERT_SASH, weight = 200 }, -- Desert Sash
        { item = xi.item.FOREST_SASH, weight = 200 }, -- Forest Sash
    },

    {
        { item = xi.item.NONE, weight = 100 }, -- Nothing
        { item = xi.item.STAFF_STRAP, weight = 225 }, -- Staff Strap
        { item = xi.item.CLAYMORE_GRIP, weight = 225 }, -- Claymore Grip
        { item = xi.item.POLE_GRIP, weight = 225 }, -- Pole Grip
        { item = xi.item.SPEAR_STRAP, weight = 225 }, -- Spear Strap
    },

    {
        { item = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight = 87 }, -- Vial Of Black Beetle Blood
        { item = xi.item.DAMASCUS_INGOT, weight = 14 }, -- Damascus Ingot
        { item = xi.item.SQUARE_OF_DAMASCENE_CLOTH, weight = 29 }, -- Square Of Damascene Cloth
        { item = xi.item.SPOOL_OF_MALBORO_FIBER, weight = 43 }, -- Spool Of Malboro Fiber
        { item = xi.item.PHILOSOPHERS_STONE, weight = 174 }, -- Philosophers Stone
        { item = xi.item.PHOENIX_FEATHER, weight = 246 }, -- Phoenix Feather
        { item = xi.item.SQUARE_OF_RAXA, weight = 159 }, -- Square Of Raxa
    },

    {
        { item = xi.item.SCROLL_OF_CURE_V, weight = 50 }, -- Scroll of Cure V
        { item = xi.item.SCROLL_OF_SHELL_IV, weight = 50 }, -- Scroll of Shell IV
        { item = xi.item.LIGHT_SPIRIT_PACT, weight = 40 }, -- Light Spirit Pact
        { item = xi.item.HI_RERAISER, weight = 220 }, -- Hi Reraiser
        { item = xi.item.CHUNK_OF_ADAMAN_ORE, weight = 20 }, -- Chunk of Adaman Ore
        { item = xi.item.SQUARE_OF_RAINBOW_CLOTH, weight = 25 }, -- Square of Rainbow Cloth
        { item = xi.item.PETRIFIED_LOG, weight = 60 }, -- Petrified Log
        { item = xi.item.MAHOGANY_LOG, weight = 75 }, -- Mahogany Log
        { item = xi.item.CORAL_FRAGMENT, weight = 85 }, -- Coral Fragment
        { item = xi.item.DEMON_HORN, weight = 70 }, -- Demon Horn
        { item = xi.item.RAM_HORN, weight = 95 }, -- Ram Horn
        { item = xi.item.SLAB_OF_GRANITE, weight = 85 }, -- Slab of Granite
        { item = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight = 100 }, -- Chunk of Darksteel Ore
        { item = xi.item.CHUNK_OF_PLATINUM_ORE, weight = 25 }, -- Chunk of Platinum Ore
    },
}

return content:register()
