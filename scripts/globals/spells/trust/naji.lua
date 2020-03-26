-----------------------------------------
-- Trust: Naji
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
    mob:addListener("ENMITY_CHANGED", "NAJI_ENMITY_CHANGED", function(trust, master, target)
        if trust:getID() ~= target:getID() then
            trust:setLocalVar("tryProvoke", 1)
        end
    end)

    mob:addListener("COMBAT_TICK", "NAJI_COMBAT_TICK", function(trust, master, target)
        local tryProvoke = trust:getLocalVar("tryProvoke")
        local provokeReadyTime = trust:getLocalVar("provokeReadyTime")

        if tryProvoke == 1 and os.time() >= provokeReadyTime then
            trust:useMobAbility(1945, target)
            trust:setLocalVar("tryProvoke", 0)
            trust:setLocalVar("provokeReadyTime", os.time() + 30)
        end

        if trust:getTP() >= 1000 then
            local weaponSkills = {33, 34, 40}
            local ws = weaponSkills[math.random(1, #weaponSkills)]
            trust:useMobAbility(ws, target)
        end
    end)
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end
