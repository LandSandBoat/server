-----------------------------------
-- TOAU-44: Nashmeira's Plea
-- !instance 59
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceCreated = function(instance)
    SpawnMob(ID.mob[59].RAUBAHN, instance)
    SpawnMob(ID.mob[59].RAZFAHD, instance)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
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

--instance_object.onEventUpdate = function(player, csid, option)
--end

--instance_object.onEventFinish = function(player, csid, option)
--end

return instance_object
