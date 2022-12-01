-----------------------------------
-- COR AF2: Against All Odds
-- !instance 6001
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LIFE_FLOAT) and
        player:getCharVar("AgainstAllOdds") == 2
end

instanceObject.entryRequirements = function(player)
    return true -- TODO
end

instanceObject.onInstanceCreated = function(instance)
    for i, v in pairs(ID.mob[54]) do
        SpawnMob(v, instance)
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.LIFE_FLOAT)
    player:delKeyItem(xi.ki.LIFE_FLOAT)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress == 2 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        if v:getCharVar("AgainstAllOdds") == 2 then
            v:setCharVar("AgainstAllOdds", 3)
            v:setCharVar("AgainstAllOddsTimer", 0)
        end

        v:startEvent(102)
    end
end

return instanceObject
