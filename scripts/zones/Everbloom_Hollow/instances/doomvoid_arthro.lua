-----------------------------------
-- doomvoid_arthro
-- !instance 8600
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

-- Called on the instance, once it is created and ready
instance_object.onInstanceCreated = function(instance)
end

-- Once the instance is ready, inform the requester that it's ready
instance_object.onInstanceCreatedCallback = function(player, instance)
    player:setInstance(instance)
    player:setPos(0, 0, 0, 0, instance:getZone():getID())
end

-- When the player zones into the instance
instance_object.afterInstanceRegister = function(player)
end

-- Instance "tick"
instance_object.onInstanceTimeUpdate = function(instance, elapsed)
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
