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
    [xi.zone.EAST_SARUTABARUTA] =
    {
        [819] = { 75, 200, 'Prickly_Pitriv', 1, true },
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

        -- TODO: Set this localvar on all qualifying members here!
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
