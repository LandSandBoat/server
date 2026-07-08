-----------------------------------
-- TOAU-44: Nashmeira's Plea
-- !instance 7701
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and
        player:hasKeyItem(xi.ki.MYTHRIL_MIRROR) and
        player:getMissionStatus(xi.mission.log_id.TOAU) == 1
end

instanceObject.entryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.NASHMEIRAS_PLEA
end

instanceObject.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.RAUBAHN, instance)
    SpawnMob(ID.mob.RAZFAHD, instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)

    -- Kill the Nyzul Isle update spam
    for _, v in ipairs(player:getParty()) do
        if v:getZoneID() == instance:getEntranceZoneID() then
            v:updateEvent(405, 3, 3, 3, 3, 3, 3, 3)
        end
    end
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())

    player:delKeyItem(xi.ki.MYTHRIL_MIRROR)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress == 4 then
        local chars = instance:getChars()
        local entryPos = instance:getEntryPos()

        DespawnMob(ID.mob.RAUBAHN, instance)
        DespawnMob(ID.mob.RAZFAHD, instance)
        for i, v in pairs(chars) do
            v:startEvent(203)
            v:setPos(entryPos.x, entryPos.y, entryPos.z, entryPos.rot)
        end

        SpawnMob(ID.mob.ALEXANDER, instance)

    elseif progress == 5 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if
            v:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and
            v:getMissionStatus(xi.mission.log_id.TOAU) == 1
        then
            v:setMissionStatus(xi.mission.log_id.TOAU, 2)
        end

        v:setPos(0, 0, 0, 0, 72)
    end
end

instanceObject.onEventFinish = function(player, csid, option, npc)
end

return instanceObject
