-----------------------------------
-- doomvoid
-- !instance 9302
--
-- WIKI:
-- - Lambton Worm boss fight for WotG Mission 24: Distorter of Time.
-- - Player enters from Beaucedine Glacier [S] after obtaining the Umbra Bug key item.
-- - Defeat Lambton Worm to complete the instance.
-- - On completion, event 10000 fires and the mission script handles the rest.
-----------------------------------
local ID = zones[xi.zone.RUHOTZ_SILVERMINES]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.UMBRA_BUG)
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.UMBRA_BUG)
end

instanceObject.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.LAMBTON_WORM, instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    player:delKeyItem(xi.ki.UMBRA_BUG)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    local mob = GetMobByID(ID.mob.LAMBTON_WORM, instance)

    if mob and mob:isDead() then
        instance:complete()
    end
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        xi.mission.setVar(
            v,
            xi.mission.log_id.WOTG,
            xi.mission.id.wotg.DISTORTER_OF_TIME,
            'Timer',
            VanadielUniqueDay() + 1
        )

        v:setPos(51.641, -41.230, 98.680, 0, xi.zone.BEAUCEDINE_GLACIER_S)
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
