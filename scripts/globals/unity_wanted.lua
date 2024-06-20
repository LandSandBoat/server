-----------------------------------
-- Unity Wanted
-----------------------------------
require('scripts/globals/confrontation')
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.unityWanted = {}

-- NOTE: mogGroupOffset is used to determine which mob(s) to spawn for
-- the specified fight.  In some cases, there is more than one mob
-- associated with the group.

-- [roeId] = { suggestedLevel, numAccolades, mobName, mobGroupOffset, experimental },
local unityWantedData =
{
    [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
    {
        [899] = { 128, 2400, 'Vidmapire', 1, true },
    },

    [xi.zone.ATTOHWA_CHASM] =
    {
        [861] = { 125, 2100, 'Muut', 9, true },
    },

    [xi.zone.AYDEEWA_SUBTERRANE] =
    {
        [924] = { 145, 4100, 'Tumult_Curator', 52, true },
    },

    [xi.zone.BATALLIA_DOWNS] =
    {
        [828] = { 125, 2100, 'Lumber_Jill', 1, true },
    },

    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        [833] = { 125, 2100, 'Largantua', 1, true },
    },

    [xi.zone.BEHEMOTHS_DOMINION] =
    {
        [914] = { 135, 3100, 'Sovereign_Behemoth', 1, true },
    },

    [xi.zone.BIBIKI_BAY] =
    {
        [825] = { 119, 1500, 'Intuila', 1, true },
    },

    [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
    {
        [891] = { 122, 1800, 'Garbage_Gel', 1, true },
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        [824] = { 119, 1500, 'Abyssdiver', 1, true },
    },

    [xi.zone.CAEDARVA_MIRE] =
    {
        [923] = { 135, 3100, 'Shedu', 1, true },
    },

    [xi.zone.CAPE_TERIGGAN] =
    {
        [858] = { 128, 2400, 'Vedrfolnir', 1, true },
        [919] = { 128, 2400, 'Glazemane',  1, true },
    },

    [xi.zone.CARPENTERS_LANDING] =
    {
        [827] = { 119, 1500, 'Orcfeltrap', 1, true },
    },

    [xi.zone.DEN_OF_RANCOR] =
    {
        [868] = { 128, 2400, 'Azrael', 1, true },
    },

    [xi.zone.EAST_RONFAURE] =
    {
        [817] = { 75, 200, 'Hugemaw_Harold', 1, true },
    },

    [xi.zone.EAST_SARUTABARUTA] =
    {
        [819] = { 75, 200, 'Prickly_Pitriv', 1, true },
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        [836] = { 122, 1800, 'Cactrot_Veloz', 1, true },
    },

    [xi.zone.FEIYIN] =
    {
        [869] = { 128, 2400, 'Orientalis_Shadow', 4, true },
        [918] = { 128, 2400, 'Carousing_Celine',  1, true },
    },

    [xi.zone.GARLAIGE_CITADEL] =
    {
        [864] = { 125, 2100, 'Mephitas', 1, true },
    },

    [xi.zone.GUSTAV_TUNNEL] =
    {
        [920] = { 128, 2400, 'Wyvernhunter_Bambrox', 9, true },
    },

    [xi.zone.IFRITS_CAULDRON] =
    {
        [865] = { 125, 2100, 'Coca', 1, true },
    },

    [xi.zone.JUGNER_FOREST] =
    {
        [826] = { 122, 1800, 'Emperor_Arthro', 1, true },
    },

    [xi.zone.KONSCHTAT_HIGHLANDS] =
    {
        [821] = { 99, 400, 'Sleepy_Mabel', 1, true },
    },

    [xi.zone.KUFTAL_TUNNEL] =
    {
        [867] = { 125, 2100, 'Specter_Worm', 1, true },
    },

    [xi.zone.LA_THEINE_PLATEAU] =
    {
        [820] = { 99, 400, 'Ironhorn_Baldurno', 1, true },
    },

    [xi.zone.LABYRINTH_OF_ONZOZO] =
    {
        [863] = { 122, 1800, 'Voso', 1, true },
    },

    [xi.zone.LUFAISE_MEADOWS] =
    {
        [859] = { 119, 1500, 'Immanibugard',        1, true },
        [894] = { 125, 2100, 'Vermillion_Fishfly', 10, true },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        [831] = { 122, 1800, 'Warblade_Beak', 1, true },
    },

    [xi.zone.MISAREAUX_COAST] =
    {
        [860] = { 122, 1800, 'Tiyanak',          1, true },
        [895] = { 128, 2400, 'Volatile_Cluster', 1, true },
    },

    [xi.zone.MOUNT_ZHAYOLM] =
    {
        [897] = { 128, 2400, 'Grand_Grenade', 1, true },
        [922] = { 135, 3100, 'Sarama',        1, true },
    },

    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        [829] = { 122, 1800, 'Joyous_Green', 1, true },
    },

    [xi.zone.QUFIM_ISLAND] =
    {
        [835] = { 119, 1500, 'Jester_Malatrix', 1, true },
    },

    [xi.zone.QUICKSAND_CAVES] =
    {
        [898] = { 125, 2100, 'Centurio_XX-I', 1, true },
    },

    [xi.zone.ROLANBERRY_FIELDS] =
    {
        [830] = { 125, 2100, 'Strix', 1, true },
    },

    [xi.zone.ROMAEVE] =
    {
        [856] = { 125, 2100, 'Douma_Weapon', 7, true },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN] =
    {
        [832] = { 125, 2100, 'Arke', 1, true },
    },

    [xi.zone.SEA_SERPENT_GROTTO] =
    {
        [892] = { 125, 2100, 'Bakunawa', 3, true },
    },

    [xi.zone.SOUTH_GUSTABERG] =
    {
        [818] = { 75, 200, 'Bounding_Belinda', 1, true },
    },

    [xi.zone.TAHRONGI_CANYON] =
    {
        [823] = { 99, 400, 'Serpopard_Ninlil', 1, true },
    },

    [xi.zone.TEMPLE_OF_UGGALEPIH] =
    {
        [893] = { 125, 2100, 'Azure-toothed_Clawberry', 7, true },
    },

    [xi.zone.THE_BOYAHDA_TREE] =
    {
        [866] = { 125, 2100, 'Ayapec',   1, true },
        [915] = { 135, 3100, 'Hidhaegg', 1, true },
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        [855] = { 122, 1800, 'Keeper_of_Heiligtum', 1, true },
    },

    [xi.zone.ULEGUERAND_RANGE] =
    {
        [862] = { 128, 2400, 'Camahueto', 1, true },
    },

    [xi.zone.VALKURM_DUNES] =
    {
        [822] = { 119, 1500, 'Valkurm_Imperator', 1, true },
    },

    [xi.zone.VALLEY_OF_SORROWS] =
    {
        [916] = { 135, 3100, 'Tolba', 1, true },
    },

    [xi.zone.WAJAOM_WOODLANDS] =
    {
        [896] = { 125, 2100, 'Kubool_Jas_Mhuufya', 1, true },
        [921] = { 135, 3100, 'Thuban',             1, true },
    },

    [xi.zone.WESTERN_ALTEPA_DESERT] =
    {
        [857] = { 125, 2100, 'King_Uropygid', 1, true },
    },

    [xi.zone.XARCABARD] =
    {
        [834] = { 125, 2100, 'Beist', 1, true },
    },

    [xi.zone.YHOATOR_JUNGLE] =
    {
        [837] = { 122, 1800, 'Woodland_Mender', 1, true },
    },

    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        [854] = { 119, 1500, 'Sybaritic_Samantha', 1, true },
    },
}

-- Get List of available Objectives in current zone that the player
-- has flagged.
local function getActiveObjectivesByZone(player)
    local flaggedObjectives = {}
    for roeId, objectiveData in pairs(unityWantedData[player:getZoneID()]) do
        if player:hasEminenceRecord(roeId) then
            table.insert(flaggedObjectives, roeId)
        end
    end

    return flaggedObjectives
end

local unityWantedWin = function(player)
end

local unityWantedLose = function(player)
    player:clearObjectiveUtility()
end

xi.unityWanted.junctionOnTrigger = function(player, npc)
    local partyLeader = player:getPartyLeader()
    if
        partyLeader and
        partyLeader ~= player
    then
        player:messageSpecial(7640)
    end

    local npcId       = npc:getID()
    local eventId     = 9000
    local triggerList = player:getZone():queryEntitiesByName('Ethereal_Junction')

    -- Get the initial event offset depending on which Ethereal Junction the player
    -- is at.
    for triggerOffset, triggerNpcId in ipairs(triggerList) do
        if triggerNpcId:getID() == npcId then
            eventId = 9000 + triggerOffset - 1
            player:setLocalVar('unityJunction', triggerOffset - 1)
        end
    end

    local flaggedObjectives = getActiveObjectivesByZone(player)
    if #flaggedObjectives == 0 then
        -- E.Saruta ID, make generic
        player:messageSpecial(7657)
        return
    end

    if #flaggedObjectives > 1 then
        eventId = eventId + 3
        local eventParameters = { eventId, 0, 0, 0, 0, 0, 0, 0, 0 }
        for flaggedIndex, roeId in ipairs(flaggedObjectives) do
            eventParameters[10 - flaggedIndex] = roeId
        end

        player:startEvent(unpack(eventParameters))
    else
        local roeId          = flaggedObjectives[1]
        local objectiveData = unityWantedData[player:getZoneID()][roeId]

        player:startEvent(eventId, roeId, objectiveData[2], objectiveData[1])
    end
end

xi.unityWanted.junctionOnEventUpdate = function(player, csid, option, npc)
    -- Since we know about the selected objective here, add checks and messaging for party member
    -- eligibility.
    if
        csid >= 9003 and
        csid <= 9005 and
        option >= 13 and
        option <= 20
    then
        local flaggedObjectives  = getActiveObjectivesByZone(player)
        local requestedObjective = flaggedObjectives[option - 12]
        local objectiveData      = unityWantedData[player:getZoneID()][requestedObjective]

        player:updateEvent(objectiveData[2], objectiveData[1])
    elseif option == 12 then
        local optionIndex   = bit.rshift(option, 8) + 1
        local selectedRoeId = getActiveObjectivesByZone(player)[optionIndex]
        local objectiveData = unityWantedData[player:getZoneID()][selectedRoeId]

        -- First parameter of the event update determines the event finish option.  If we
        -- want to bail out for any reason, update the first parameter to a non-1 value.

        player:setLocalVar('unityWanted', selectedRoeId)
        player:updateEvent(1, 0, 0, 50000, 0, 0, 13395, 0)
    end
end

xi.unityWanted.junctionOnEventFinish = function(player, csid, option, npc)
    if option == 1 then
        local junctionOffset = player:getLocalVar('unityJunction')
        local roeId          = player:getLocalVar('unityWanted')
        local objectiveData  = unityWantedData[player:getZoneID()][roeId]
        local mobObjOffset   = player:getZone():queryEntitiesByName(objectiveData[3])[1]
        local spawnedMobId   = mobObjOffset:getID() + junctionOffset * objectiveData[4]

        if
            not GetMobByID(spawnedMobId):isSpawned() and
            npcUtil.popFromQM(player, npc, spawnedMobId, { hide = 30 })
        then
            local confrontationInfo =
            {
                countdown = utils.minutes(15),
                fence =
                {
                    pos    = { x = npc:getXPos(), y = npc:getZPos() },
                    radius = 50,
                    render = 25,
                }
            }

            for _, playerObj in ipairs(player:getAlliance()) do
                -- Only set local if player has objective, if in fight when added, give message
                -- it will take effect on the next battle.
                player:setLocalVar('unityWanted', roeId)
                player:objectiveUtility(confrontationInfo)
            end

            local spawnedMob = GetMobByID(spawnedMobId)
            spawnedMob:setLocalVar('unityWanted', roeId)

            if objectiveData[5] then
                spawnedMob:setMobLevel(math.min(spawnedMob:getMainLvl() * 2, 255))
            end

            xi.confrontation.start(player, npc, spawnedMobId, unityWantedWin, unityWantedLose)
        end
    end
end

xi.unityWanted.onMobDeath = function(mob, player, optParams)
    local playerRoeId = player:getLocalVar('unityWanted')
    local mobRoeId    = mob:getLocalVar('unityWanted')

    if
        playerRoeId > 0 and
        playerRoeId == mobRoeId
    then
        xi.roe.onRecordTrigger(player, mobRoeId)
    end

    player:clearObjectiveUtility()
end
