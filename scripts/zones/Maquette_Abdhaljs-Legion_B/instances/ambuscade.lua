-----------------------------------
-- Ambuscade
-- !instance 30000
-----------------------------------
local ID = require("scripts/zones/Maquette_Abdhaljs-Legion_B/IDs")
require("scripts/globals/instance")
-----------------------------------
local instanceObject = {}

-- Called on the instance, once it is created and ready
instanceObject.onInstanceCreated = function(instance)
    for i, mobId in pairs(ID.mob) do
        SpawnMob(mobId, instance)
    end
end

-- Once the instance is ready, inform the requester that it's ready
instanceObject.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
end

-- When the player zones into the instance
instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:countdown(instance:getTimeLimit() * 60)
end

-- Instance "tick"
instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    --xi.instance.updateInstanceTime(instance, elapsed, ID.text)

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
instanceObject.onInstanceFailure = function(instance)
    xi.ambuscade.onInstanceFailure(instance)
end

-- When something in the instance calls: instance:setProgress(...)
instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

-- On win
instanceObject.onInstanceComplete = function(instance)
    xi.ambuscade.onInstanceComplete(instance)
end

instanceObject.onEventUpdate = function(player, csid, option)
end

instanceObject.onEventFinish = function(player, csid, option)
    if csid == 10001 then
        player:setPos(-34.2, -16, 58, 32, 249)
    end
end

return instanceObject
