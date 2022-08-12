-----------------------------------
-- A Nation on the Brink
-- !instance 8600
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

local entities = {}

instance_object.onInstanceCreated = function(instance)
    local zone = instance:getZone()
    local baseID = zone:queryEntitiesByName("Rongelouts_N_Distaud", instance)[1]:getID()

    entities.Rongelouts = baseID + 0

    for _, entityID in pairs(entities) do
        SpawnMob(entityID, instance)
    end
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(-158, 20, -156, 166, instance:getZone():getID()) -- TODO: This isn't working?
    end
end

instance_object.afterInstanceRegister = function(player)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:setPos(-34.2, -16, 58, 32, xi.zone.BATALLIA_DOWNS_S)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
end

instance_object.onInstanceComplete = function(instance)
end

return instance_object
