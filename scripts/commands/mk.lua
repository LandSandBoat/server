-----------------------------------
-- func: masterkey
-- desc: opens doors
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 'i'
}

local function isGM(player)
    return player:getGMLevel() > 0
end

local function hasKeyItemsOrIsGM(keyItems)
    if type(keyItems) == 'number' then
        keyItems = { keyItems }
    end

    return function(player)
        if player:getGMLevel() > 0 then
            return true
        end

        for _, keyItem in ipairs(keyItems) do
            if not player:hasKeyItem(keyItem) then
                return false
            end
        end

        return true
    end
end

local npcToDoorMap = {
    -- Adjusting value for Ifrit's Cauldron Flame Spouts
    [zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 0] = zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 5,
    [zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 1] = zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 6,
    [zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 2] = zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 7,
    [zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 3] = zones[xi.zone.IFRITS_CAULDRON].npc.FLAME_SPOUT_OFFSET + 8,
    -- Adjusting value for the Cast Iron Gates in Halvung
    [zones[xi.zone.HALVUNG].npc.LEVER_AB_DOOR + 2] = zones[xi.zone.HALVUNG].npc.LEVER_AB_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_AB_DOOR + 3] = zones[xi.zone.HALVUNG].npc.LEVER_AB_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_CD_DOOR + 2] = zones[xi.zone.HALVUNG].npc.LEVER_CD_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_CD_DOOR + 3] = zones[xi.zone.HALVUNG].npc.LEVER_CD_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_EF_DOOR + 2] = zones[xi.zone.HALVUNG].npc.LEVER_EF_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_EF_DOOR + 3] = zones[xi.zone.HALVUNG].npc.LEVER_EF_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_GH_DOOR + 2] = zones[xi.zone.HALVUNG].npc.LEVER_GH_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_GH_DOOR + 3] = zones[xi.zone.HALVUNG].npc.LEVER_GH_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_IJ_DOOR + 2] = zones[xi.zone.HALVUNG].npc.LEVER_IJ_DOOR,
    [zones[xi.zone.HALVUNG].npc.LEVER_IJ_DOOR + 3] = zones[xi.zone.HALVUNG].npc.LEVER_IJ_DOOR,
    -- Adjusting value for Stone Frame Picture Door
    [zones[xi.zone.TEMPLE_OF_UGGALEPIH].npc.DOOR_TO_RANCOR + 1] = zones[xi.zone.TEMPLE_OF_UGGALEPIH].npc.DOOR_TO_RANCOR,
    -- Adjusting value for Phomiuna Aqueducts oil lamps
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 0] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 1] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 2] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 3] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 4] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 5] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 6] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    [zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET + 7] = zones[xi.zone.PHOMIUNA_AQUEDUCTS].npc.OIL_LAMP_OFFSET - 2,
    -- Adjusting value for Sarcarium key door
    [zones[xi.zone.SACRARIUM].npc.SMALL_KEYHOLE - 1] = zones[xi.zone.SACRARIUM].npc.SMALL_KEYHOLE - 3,
    [zones[xi.zone.SACRARIUM].npc.SMALL_KEYHOLE - 0] = zones[xi.zone.SACRARIUM].npc.SMALL_KEYHOLE - 3,
    -- Adjusting value for the guards to Alzadaal Undersea Ruins
    [zones[xi.zone.BHAFLAU_THICKETS].npc.KAMIH_MAPOKHALAM] = zones[xi.zone.BHAFLAU_THICKETS].npc.KAMIH_MAPOKHALAM - 2,
    [zones[xi.zone.BHAFLAU_THICKETS].npc.HAMTAIRAMTA] = zones[xi.zone.BHAFLAU_THICKETS].npc.HAMTAIRAMTA - 2,
    [zones[xi.zone.CAEDARVA_MIRE].npc.TYAMAH] = zones[xi.zone.CAEDARVA_MIRE].npc.TYAMAH - 4,
    [zones[xi.zone.CAEDARVA_MIRE].npc.NASHEEFA] = zones[xi.zone.CAEDARVA_MIRE].npc.NASHEEFA - 4,
    [zones[xi.zone.CAEDARVA_MIRE].npc.NUIMAHN] = zones[xi.zone.CAEDARVA_MIRE].npc.NUIMAHN - 4,
    [zones[xi.zone.CAEDARVA_MIRE].npc.KWADAAF] = zones[xi.zone.CAEDARVA_MIRE].npc.KWADAAF - 4,
    [zones[xi.zone.MOUNT_ZHAYOLM].npc.BAPOKK] = zones[xi.zone.MOUNT_ZHAYOLM].npc.BAPOKK - 1,
    -- Adjusting value for opening the gate in Zeruhn Mines to Korroloka Tunnel
    [zones[xi.zone.ZERUHN_MINES].npc.LASTHENES] = zones[xi.zone.ZERUHN_MINES].npc.DOOR_TO_KORROLOKA_TUNNEL,
    -- Raise the whole drawbridge when clicking any Rusty Lever.
    [zones[xi.zone.OLDTON_MOVALPOLOS].npc.RUSTY_LEVER_OFFSET + 0] = { zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 0, zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 2, zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 4, reverse = true, closeSeconds = 30, },
    [zones[xi.zone.OLDTON_MOVALPOLOS].npc.RUSTY_LEVER_OFFSET + 1] = { zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 0, zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 2, zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 4, reverse = true, closeSeconds = 30, },
    [zones[xi.zone.OLDTON_MOVALPOLOS].npc.RUSTY_LEVER_OFFSET + 2] = { zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 0, zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 2, zones[xi.zone.OLDTON_MOVALPOLOS].npc.DROP_FLOOR_OFFSET + 4, reverse = true, closeSeconds = 30, },
    -- Opening multiple gates in Newton Movalpolos from Furnace Hatches.
    [zones[xi.zone.NEWTON_MOVALPOLOS].npc.FURNACE_HATCH_OFFSET + 0] = { zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 0, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 1, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 2, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 3, },
    [zones[xi.zone.NEWTON_MOVALPOLOS].npc.FURNACE_HATCH_OFFSET + 1] = { zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 4, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 5, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 6, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 7, },
    [zones[xi.zone.NEWTON_MOVALPOLOS].npc.FURNACE_HATCH_OFFSET + 2] = { zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 8, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 9, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 10, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 11, },
    [zones[xi.zone.NEWTON_MOVALPOLOS].npc.FURNACE_HATCH_OFFSET + 3] = { zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 8, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 9, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 10, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 11, },
    [zones[xi.zone.NEWTON_MOVALPOLOS].npc.FURNACE_HATCH_OFFSET + 4] = { zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 8, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 9, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 10, zones[xi.zone.NEWTON_MOVALPOLOS].npc.DOOR_OFFSET + 11, },
    -- Requiring Cerulean Crystal to use on the Cermet Grate in Hall of the Gods
    [zones[xi.zone.HALL_OF_THE_GODS].npc.CERMET_GATE] = {
        zones[xi.zone.HALL_OF_THE_GODS].npc.CERMET_GATE,
        closeSeconds = 1,
        check = hasKeyItemsOrIsGM(xi.ki.CERULEAN_CRYSTAL),
        failureMessage = 'You must complete Rise of the Zilart missions up to ZM13 to use this command here.',
    },
    -- Requiring Crest of Davoi for Wall of Dark Arts in Davoi
    [zones[xi.zone.DAVOI].npc.WALL_OF_DARK_ARTS] = {
        zones[xi.zone.DAVOI].npc.WALL_OF_DARK_ARTS,
        closeSeconds = 1,
        check = hasKeyItemsOrIsGM(xi.ki.CREST_OF_DAVOI_KI),
        failureMessage = 'You must have the Crest of Davoi to use this command here.',
    },
    -- Requiring Crimson Orb for the Wall of Banishing in Davoi
    [zones[xi.zone.DAVOI].npc.WALL_OF_BANISHING] = {
        zones[xi.zone.DAVOI].npc.WALL_OF_BANISHING,
        closeSeconds = 1,
        check = hasKeyItemsOrIsGM(xi.ki.CRIMSON_ORB),
        failureMessage = 'You must have the Crimson Orb to use this command here.',
    },
    -- Requiring Silver Bell, Coruscant Rosary, and Black Matinee Necklace in Qulun Dome
    [zones[xi.zone.QULUN_DOME].npc.LOCKED_DOOR_OFFSET + 0] = {
        zones[xi.zone.QULUN_DOME].npc.LOCKED_DOOR_OFFSET + 0,
        closeSeconds = 1,
        check = hasKeyItemsOrIsGM({ xi.ki.SILVER_BELL, xi.ki.CORUSCANT_ROSARY, xi.ki.BLACK_MATINEE_NECKLACE }),
        failureMessage = 'You need the Silver Bell, Coruscant Rosary, and the Black Matinee Necklace to use this command here.',
    },
    [zones[xi.zone.QULUN_DOME].npc.LOCKED_DOOR_OFFSET + 1] = {
        zones[xi.zone.QULUN_DOME].npc.LOCKED_DOOR_OFFSET + 1,
        closeSeconds = 1,
        check = hasKeyItemsOrIsGM({ xi.ki.SILVER_BELL, xi.ki.CORUSCANT_ROSARY, xi.ki.BLACK_MATINEE_NECKLACE }),
        failureMessage = 'You need the Silver Bell, Coruscant Rosary, and the Black Matinee Necklace to use this command here.',
    },
    -- Requiring Yagudo Torch in Castle Oztroja
    [zones[xi.zone.CASTLE_OZTROJA].npc.LOCKED_DOOR] = {
        zones[xi.zone.CASTLE_OZTROJA].npc.LOCKED_DOOR,
        closeSeconds = 1,
        check = hasKeyItemsOrIsGM(xi.ki.YAGUDO_TORCH),
        failureMessage = 'You need the Yagudo Torch to use this command here.'
    },
    -- Adjusting value for password door in Castle Oztroja
    [zones[xi.zone.CASTLE_OZTROJA].npc.FINAL_PASSWORD_STATUE] = zones[xi.zone.CASTLE_OZTROJA].npc.TRAP_DOOR_FLOOR_4,
    -- Tenshodo door
    [zones[xi.zone.LOWER_JEUNO].npc.TENSHODO_LOCKED_DOOR] = {
        zones[xi.zone.LOWER_JEUNO].npc.TENSHODO_LOCKED_DOOR,
        closeSeconds = 1,
        check = hasKeyItemsOrIsGM(xi.ki.TENSHODO_MEMBERS_CARD),
        failureMessage = 'You must have the Tenshodo Member\'s Card to enter here.'
    },
    -- Disabling mk use for Tenzen's Path
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 0]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 0, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 1]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 1, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 2]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 2, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 3]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 3, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 4]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 4, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 5]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 5, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 6]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 6, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 7]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 7, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 8]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 8, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 9]  = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 9, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 10] = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 10, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 11] = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 11, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 12] = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 12, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 13] = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 13, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 14] = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 14, check = isGM },
    [zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 15] = { zones[xi.zone.PSOXJA].npc.STONE_DOOR_OFFSET + 15, check = isGM },
    -- Disable mk use for Imperial Agent Rescue Pot Hatch
    [zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS].npc.POT_HATCH + 0] = { zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS].npc.POT_HATCH + 0, check = isGM },
    [zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS].npc.POT_HATCH + 1] = { zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS].npc.POT_HATCH + 1, check = isGM },
    [zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS].npc.POT_HATCH + 2] = { zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS].npc.POT_HATCH + 2, check = isGM },
    -- Disabling mk for airship/ferry entrances
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_GUARD_OFFSET + 0]   = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 2, check = isGM },
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_GUARD_OFFSET + 1]   = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_GUARD_OFFSET + 2]   = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 3, check = isGM },
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_GUARD_OFFSET + 3]   = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 0] = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 1] = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 2] = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 2, check = isGM },
    [zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 3] = { zones[xi.zone.AHT_URHGAN_WHITEGATE].npc.FERRY_BLOCKER_OFFSET + 3, check = isGM },
    [zones[xi.zone.NASHMAU].npc.FERRY_GUARD_OFFSET + 0]                = { zones[xi.zone.NASHMAU].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.NASHMAU].npc.FERRY_GUARD_OFFSET + 1]                = { zones[xi.zone.NASHMAU].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.NASHMAU].npc.FERRY_BLOCKER_OFFSET + 0]              = { zones[xi.zone.NASHMAU].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.NASHMAU].npc.FERRY_BLOCKER_OFFSET + 1]              = { zones[xi.zone.NASHMAU].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.SELBINA].npc.FERRY_GUARD_OFFSET + 0]                = { zones[xi.zone.SELBINA].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.SELBINA].npc.FERRY_GUARD_OFFSET + 1]                = { zones[xi.zone.SELBINA].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.SELBINA].npc.FERRY_BLOCKER_OFFSET + 0]              = { zones[xi.zone.SELBINA].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.SELBINA].npc.FERRY_BLOCKER_OFFSET + 1]              = { zones[xi.zone.SELBINA].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.MHAURA].npc.FERRY_GUARD_OFFSET + 0]                 = { zones[xi.zone.MHAURA].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.MHAURA].npc.FERRY_GUARD_OFFSET + 1]                 = { zones[xi.zone.MHAURA].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.MHAURA].npc.FERRY_BLOCKER_OFFSET + 0]               = { zones[xi.zone.MHAURA].npc.FERRY_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.MHAURA].npc.FERRY_BLOCKER_OFFSET + 1]               = { zones[xi.zone.MHAURA].npc.FERRY_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.KAZHAM].npc.AIRSHIP_GUARD_OFFSET + 0]               = { zones[xi.zone.KAZHAM].npc.AIRSHIP_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.KAZHAM].npc.AIRSHIP_GUARD_OFFSET + 1]               = { zones[xi.zone.KAZHAM].npc.AIRSHIP_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.KAZHAM].npc.AIRSHIP_BLOCKER_OFFSET + 0]             = { zones[xi.zone.KAZHAM].npc.AIRSHIP_BLOCKER_OFFSET + 0, check = isGM },
    [zones[xi.zone.KAZHAM].npc.AIRSHIP_BLOCKER_OFFSET + 1]             = { zones[xi.zone.KAZHAM].npc.AIRSHIP_BLOCKER_OFFSET + 1, check = isGM },
    [zones[xi.zone.PORT_SAN_DORIA].npc.AIRSHIP_DOOR_OFFSET + 1]        = { zones[xi.zone.PORT_SAN_DORIA].npc.AIRSHIP_DOOR_OFFSET + 1, check = isGM },
    [zones[xi.zone.PORT_SAN_DORIA].npc.AIRSHIP_DOOR_OFFSET + 3]        = { zones[xi.zone.PORT_SAN_DORIA].npc.AIRSHIP_DOOR_OFFSET + 3, check = isGM },
    [zones[xi.zone.PORT_BASTOK].npc.AIRSHIP_DOOR_OFFSET + 2]           = { zones[xi.zone.PORT_BASTOK].npc.AIRSHIP_DOOR_OFFSET + 2, check = isGM },
    [zones[xi.zone.PORT_BASTOK].npc.AIRSHIP_DOOR_OFFSET + 3]           = { zones[xi.zone.PORT_BASTOK].npc.AIRSHIP_DOOR_OFFSET + 3, check = isGM },
    [zones[xi.zone.PORT_WINDURST].npc.AIRSHIP_DOOR_OFFSET + 0]         = { zones[xi.zone.PORT_WINDURST].npc.AIRSHIP_DOOR_OFFSET + 0, check = isGM },
    [zones[xi.zone.PORT_WINDURST].npc.AIRSHIP_DOOR_OFFSET + 1]         = { zones[xi.zone.PORT_WINDURST].npc.AIRSHIP_DOOR_OFFSET + 1, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 1]            = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 1, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 3]            = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 3, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 5]            = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 5, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 7]            = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 7, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 9]            = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 9, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 11]           = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 11, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 13]           = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 13, check = isGM },
    [zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 15]           = {zones[xi.zone.PORT_JEUNO].npc.AIRSHIP_DOOR_OFFSET + 15, check = isGM },
    -- Adjusting value for Pincerstones and Portals. Used for mount purposes
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 0]  = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 0, closeSeconds = 120, }, -- Main to Seriyu
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 2]  = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 1, closeSeconds = 120, }, -- Seriyu to Main
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 4]  = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 3, closeSeconds = 120, }, -- Seriyu to Genbu
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 6]  = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 4, closeSeconds = 120, }, -- Genbu to Seriyu
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 8]  = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 6, closeSeconds = 120, }, -- Genbu to Byakko
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 10] = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 7, closeSeconds = 120, }, -- Byakko to Genbu
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 12] = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 9, closeSeconds = 120, }, -- Byakko to Suzaku
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 14] = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 10, closeSeconds = 120, }, -- Suzaku to Byakko
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 16] = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 12, closeSeconds = 120, }, -- Suzaku to Main
    [zones[xi.zone.RUAUN_GARDENS].npc.PINCERSTONE_OFFSET + 18] = { zones[xi.zone.RUAUN_GARDENS].npc.PORTAL_OFFSET + 13, closeSeconds = 120, }, -- Main to Suzaku
    -- Disabling mk for Promyvion
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 0]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 0, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 1]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 1, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 2]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 2, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 3]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 3, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 4]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 4, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 5]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 5, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 6]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 6, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 7]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 7, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 8]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 8, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 9]    = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 9, check = isGM },
    [zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 10]   = { zones[xi.zone.PROMYVION_DEM].npc.MEMORY_STREAM_OFFSET + 10, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 0]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 0, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 1]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 1, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 2]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 2, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 3]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 3, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 4]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 4, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 5]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 5, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 6]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 6, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 7]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 7, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 8]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 8, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 9]  = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 9, check = isGM },
    [zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 10] = { zones[xi.zone.PROMYVION_HOLLA].npc.MEMORY_STREAM_OFFSET + 10, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 0]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 0, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 1]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 1, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 2]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 2, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 3]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 3, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 4]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 4, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 5]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 5, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 6]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 6, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 7]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 7, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 8]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 8, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 9]    = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 9, check = isGM },
    [zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 10]   = { zones[xi.zone.PROMYVION_MEA].npc.MEMORY_STREAM_OFFSET + 10, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 0]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 0, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 1]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 1, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 2]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 2, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 3]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 3, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 4]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 4, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 5]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 5, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 6]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 6, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 7]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 7, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 8]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 8, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 9]  = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 9, check = isGM },
    [zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 10] = { zones[xi.zone.PROMYVION_VAHZL].npc.MEMORY_STREAM_OFFSET + 10, check = isGM },
}

commandObj.onTrigger = function(player, target)
    local zone = player:getZoneID()

    if not target then
        target = player:getCursorTarget()
    else
        target = GetNPCByID(target)
    end

    if not target or not target:isNPC() then
        player:printToPlayer('You must either target a door or enter a valid ID.')
        return
    end

    local targetID = target:getID()

    if
        (zone == xi.zone.ARRAPAGO_REMNANTS or
        zone == xi.zone.BHAFLAU_REMNANTS or
        zone == xi.zone.SILVER_SEA_REMNANTS or
        zone == xi.zone.ZHAYOLM_REMNANTS) and
        player:getGMLevel() == 0
    then
        player:printToPlayer('You cannot use Masterkey here.')
        return
    end

    if npcToDoorMap[targetID] then
        local map = npcToDoorMap[targetID]
        if type(map) == 'number' then
            map = { map }
        end

        map.closeSeconds   = map.closeSeconds or 15
        map.failureMessage = map.failureMessage or 'You cannot use Masterkey here.'
        map.successMessage = map.successMessage or 'Success!'

        if map.check and not map.check(player) then
            player:printToPlayer(map.failureMessage)
            return
        end

        player:printToPlayer(map.successMessage)

        for _, npcID in ipairs(map) do
            if map.reverse then
                GetNPCByID(npcID):closeDoor(map.closeSeconds)
            else
                GetNPCByID(npcID):openDoor(map.closeSeconds)
            end
        end

        return
    else
        target:openDoor(15)
        player:printToPlayer('Success!')
    end
end

return commandObj
