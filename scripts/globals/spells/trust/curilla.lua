-----------------------------------------
-- Trust: Curilla
-----------------------------------------
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addListener("ENMITY_CHANGED", "CURILLA_ENMITY_CHANGED", function(trust, master, target)
        if trust:getID() ~= target:getID() then
            trust:setLocalVar("trySentinel", 1)
        end
    end)

    mob:addListener("COMBAT_TICK", "CURILLA_COMBAT_TICK", function(trust, master, target)
        local trySentinel = trust:getLocalVar("trySentinel")
        local sentinelReadyTime = trust:getLocalVar("sentinelReadyTime")

        if trySentinel == 1 and os.time() >= sentinelReadyTime then
            trust:useMobAbility(707, target)
            trust:setLocalVar("trySentinel", 0)
            trust:setLocalVar("sentinelReadyTime", os.time() + 600)
        end

        if trust:getTP() >= 1000 then
            local weaponSkills = {34, 37, 41}
            local ws = weaponSkills[math.random(1, #weaponSkills)]
            trust:useMobAbility(ws, target)
        end
    end)
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end
