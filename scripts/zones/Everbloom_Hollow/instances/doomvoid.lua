-----------------------------------
-- doomvoid
-- !instance 8602
--
-- WIKI:
-- - After entering, you will face Lambton Worm.
-- - Kill it to complete the objective.
-- - Used by WotG Mission 14 (A Nation on the Brink) and
--   WotG Mission 23 (Dungeons and Dancers).
-- - Trusts are allowed.
-----------------------------------
local ID = zones[xi.zone.EVERBLOOM_HOLLOW]
-----------------------------------
local instanceObject = {}

instanceObject.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.LAMBTON_WORM, instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    local boss = GetMobByID(ID.mob.LAMBTON_WORM, instance)

    if boss and boss:isDead() then
        instance:complete()
    end
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        v:setPos(302.747, -1, -174.367, 31, xi.zone.BATALLIA_DOWNS_S)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        v:startEvent(10000)
    end
end

return instanceObject
