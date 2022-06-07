-----------------------------------
-- stonewalled
-- !instance 27100
-----------------------------------
require('scripts/globals/instance')
require('scripts/globals/keyitems')
local ID = require('scripts/zones/Cirdas_Caverns_U/IDs')
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return true -- player:hasKeyItem(xi.ki.AUREATE_BALL_OF_FUR)
end

instance_object.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.AUREATE_BALL_OF_FUR)
end

instance_object.onInstanceCreated = function(instance)
    SpawnMob(17887467, instance) -- TODO: Do lookup without using a hard-coded ID anywhere
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.afterInstanceRegister = function(player)
    player:countdown(player:getInstance():getTimeLimit() * 60) -- TODO: Use time remaining instead of the overall time limit
    player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.AUREATE_BALL_OF_FUR)
    player:delKeyItem(xi.ki.AUREATE_BALL_OF_FUR)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:countdown(0)
        v:setPos(-529.361, -7.000, 59.988, 0, 258)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress == 1 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        -- Complete fight
        -- local questProgVar = v:getCharVar("Quest[7][19]Prog")
        -- if questProgVar == 4 or questProgVar == 7 then
        --     v:setCharVar("Quest[7][19]Prog", 5)
        -- end
        v:startEvent(1000)
    end
end

return instance_object
