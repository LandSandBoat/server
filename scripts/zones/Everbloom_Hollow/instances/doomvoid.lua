-----------------------------------
-- doomvoid
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

instance_object.onInstanceCreated = function(instance)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
end

instance_object.afterInstanceRegister = function(player)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:setPos(-34.2, -16, 58, 32, 249)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
end

instance_object.onInstanceComplete = function(instance)
end

return instance_object
