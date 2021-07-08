-----------------------------------
-- TOAU-44: Nashmeira's Plea
-- !instance 59
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

-- Requirements for the first player registering the instance
instance_object.registryRequirements = function(player)
    return player:getCurrentMission(TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and
           player:hasKeyItem(xi.ki.MYTHRIL_MIRROR) and
           player:getCharVar("AhtUrganStatus") == 1
end

-- Requirements for further players entering an already-registered instance
instance_object.entryRequirements = function(player)
    return player:getCurrentMission(TOAU) >= xi.mission.id.toau.NASHMEIRAS_PLEA
end

instance_object.onInstanceCreated = function(instance)
    SpawnMob(ID.mob[59].RAUBAHN, instance)
    SpawnMob(ID.mob[59].RAZFAHD, instance)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)

    -- Kill the Nyzul Isle update spam
    for _, v in ipairs(player:getParty()) do
        if v:getZoneID() == instance:getEntranceZoneID() then
            v:updateEvent(405, 3, 3, 3, 3, 3, 3, 3)
        end
    end
end

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())

    player:delKeyItem(xi.ki.MYTHRIL_MIRROR)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress == 4 then
        local chars = instance:getChars()
        local entryPos = instance:getEntryPos()

        DespawnMob(ID.mob[59].RAUBAHN, instance)
        DespawnMob(ID.mob[59].RAZFAHD, instance)
        for i, v in pairs(chars) do
            v:startEvent(203)
            v:setPos(entryPos.x, entryPos.y, entryPos.z, entryPos.rot)
        end
        SpawnMob(ID.mob[59].ALEXANDER, instance)

    elseif progress == 5 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if v:getCurrentMission(TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and v:getCharVar("AhtUrganStatus") == 1 then
            v:setCharVar("AhtUrganStatus", 2)
        end

        v:setPos(0, 0, 0, 0, 72)
    end
end

return instance_object
