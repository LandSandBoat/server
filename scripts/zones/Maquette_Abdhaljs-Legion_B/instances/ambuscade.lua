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
    for i, mobId in pairs(ID.mob) do
        SpawnMob(mobId, instance)
    end
end

instance_object.onInstanceLoadFailed = function()
    return 72
end

-- Once the instance is ready, inform the requester that it's ready
instance_object.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
end

-- When the player zones into the instance
instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:countdown(instance:getTimeLimit() * 60)
end

-- Instance "tick"
instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)

    -- Check for mob death (could do also do this in the mob script)
    local mobsStillAlive = false
    local mobs = instance:getMobs()
    for _, mob in pairs(mobs) do
        if mob:isAlive() then
            mobsStillAlive = true
        end
    end

    if not mobsStillAlive then
        instance:complete()
    end
end

-- On fail
instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:startEvent(10001)
    end
end

-- When something in the instance calls: instance:setProgress(...)
instance_object.onInstanceProgressUpdate = function(instance, progress)
end

-- On win
instance_object.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:startEvent(10001)
    end
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
    if csid == 10001 then
        player:setPos(-34.2, -16, 58, 32, 249)
    end
end

return instance_object
