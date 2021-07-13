-----------------------------------
-- light_into_the_darkness
-- !instance 9300
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

-- Requirements for the first player registering the instance
instance_object.registryRequirements = function(player)
    return true
end

-- Requirements for further players entering an already-registered instance
instance_object.entryRequirements = function(player)
    return true
end

instance_object.onInstanceCreated = function(instance)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
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
