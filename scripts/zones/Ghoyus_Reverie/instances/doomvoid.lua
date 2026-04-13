-----------------------------------
-- doomvoid
-- !instance 12900
--
-- WIKI:
-- - Instance for WotG Missions 31, 32, and 33.
-- - Defeat the Lambton Worm to complete the objective.
-- - You have 84 minutes to complete the objective.
-- - Trusts are allowed.
-----------------------------------
local ID = zones[xi.zone.GHOYUS_REVERIE]
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
        local currentMission = v:getCurrentMission(xi.mission.log_id.WOTG)

        if currentMission == xi.mission.id.wotg.INTO_THE_BEASTS_MAW then
            v:setPos(179.987, -24.046, 94.225, 194, xi.zone.CASTLE_ZVAHL_BAILEYS_S)
        else
            v:setPos(96.77, -23.943, -277.87, 253, xi.zone.XARCABARD_S)
        end
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
