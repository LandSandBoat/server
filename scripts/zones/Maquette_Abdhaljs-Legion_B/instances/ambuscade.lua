-----------------------------------
-- Ambuscade
-- !instance 30000
-----------------------------------
local ID = require("scripts/zones/Maquette_Abdhaljs-Legion_B/IDs")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

-- Called on the instance, once it is created and ready
instance_object.onInstanceCreated = function(instance)
end

-- Once the instance is ready, inform the requester that it's ready
instance_object.onInstanceCreatedCallback = function(player, instance)
    -- Send player to the instance!
    player:setInstance(instance)
    player:setPos(0, 0, 0, 0, instance:getZone():getID())
end

-- When the player zones into the instance
instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

-- Instance "tick"
instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

-- On fail
instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:setPos(-34.2, -16, 58, 32, 249)
    end
end

-- When something in the instance calls: instance:setProgress(...)
instance_object.onInstanceProgressUpdate = function(instance, progress)
end

-- On win
instance_object.onInstanceComplete = function(instance)
end

return instance_object
