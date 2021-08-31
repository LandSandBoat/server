-----------------------------------
-- COR AF2: Against All Odds
-- !instance 6001
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LIFE_FLOAT) and
           player:getCharVar("AgainstAllOdds") == 2
end

instance_object.entryRequirements = function(player)
    return true -- TODO
end

instance_object.onInstanceCreated = function(instance)
    for i, v in pairs(ID.mob[54]) do
        SpawnMob(v, instance)
    end
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.LIFE_FLOAT)
    player:delKeyItem(xi.ki.LIFE_FLOAT)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress == 2 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        if v:getCharVar("AgainstAllOdds") == 2 then
            v:setCharVar("AgainstAllOdds", 3)
            v:setCharVar("AgainstAllOddsTimer",0)
        end
        v:startEvent(101)
    end
end

return instance_object
