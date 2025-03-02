-----------------------------------
-- TOAU-42: Path of Darkness
-- !instance 7700
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
local instanceObject = {}

-- Requirements for the first player registering the instance
instanceObject.registryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.PATH_OF_DARKNESS and
        player:hasKeyItem(xi.ki.NYZUL_ISLE_ROUTE) and
        player:getMissionStatus(xi.mission.log_id.TOAU) == 1
end

-- Requirements for further players entering an already-registered instance
instanceObject.entryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PATH_OF_DARKNESS
end

-- Called on the instance once it is created and ready
instanceObject.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.AMNAF_BLU, instance)
    SpawnMob(ID.mob.NAJA_SALAHEEM, instance)
end

-- Once the instance is ready inform the requester that it's ready
instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)

    -- Kill the Nyzul Isle update spam
    for _, v in ipairs(player:getParty()) do
        if v:getZoneID() == instance:getEntranceZoneID() then
            v:updateEvent(405, 3, 3, 3, 3, 3, 3, 3)
        end
    end
end

-- When the player zones into the instance
instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    -- NOTE: Time Limit observed in capture prior to KI fading.  This could be asyncronyous,
    -- but moving here from that reference.
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())

    if player:hasKeyItem(xi.ki.NYZUL_ISLE_ROUTE) then
        player:delKeyItem(xi.ki.NYZUL_ISLE_ROUTE)
        player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.NYZUL_ISLE_ROUTE)
    end

    player:addTempItem(xi.item.UNDERSEA_RUINS_FIREFLIES)
end

-- Instance "tick"
instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

-- On fail
instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

-- When something in the instance calls: instance:setProgress(...)
instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 10 and progress < 20 then
        DespawnMob(ID.mob.AMNAF_BLU, instance)
    elseif progress == 24 then
        local v = GetMobByID(ID.mob.NAJA_SALAHEEM, instance)

        if v then
            v:setLocalVar('ready', 0)
            v:setLocalVar('Stage', 2)
        end

        SpawnMob(ID.mob.AMNAF_BLU, instance)
    elseif progress >= 30 and progress < 40 then
        DespawnMob(ID.mob.AMNAF_BLU, instance)
    elseif progress == 48 then
        SpawnMob(ID.mob.AMNAF_PSYCHEFLAYER, instance)

        local v = GetMobByID(ID.mob.NAJA_SALAHEEM, instance)

        if v then
            v:setLocalVar('ready', 0)
            v:setLocalVar('Stage', 3)
        end

        local npcs = instance:getNpcs()

       -- Now we know we are closing a door. Why are we looping through all npcs just to close a single door? And why arent we stoping once we do?
        for i, value in pairs(npcs) do
            if value:getID() == ID.npc.DOOR_OFFSET + 6 then
                value:setAnimation(8)
            end
        end
    elseif progress == 50 then
        instance:complete()
    end
end

-- On win
instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if
            v:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.PATH_OF_DARKNESS and
            v:getMissionStatus(xi.mission.log_id.TOAU) == 1
        then
            v:setMissionStatus(xi.mission.log_id.TOAU, 2)
        end

        v:setPos(0, 0, 0, 0, 72)
    end
end

-- Standard event hooks, these will take priority over everything apart from m_event.Script
-- Omitting this will fallthrough to the same calls in the Zone.lua

--instanceObject.onEventUpdate = function(player, csid, option, npc)
--end

--instanceObject.onEventFinish = function(player, csid, option, npc)
--end

return instanceObject
