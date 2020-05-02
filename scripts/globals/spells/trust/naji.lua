-----------------------------------------
-- Trust: Naji
-----------------------------------------
require("scripts/globals/trust")
require("scripts/globals/zone")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    local BastokFirstTrust = caster:getCharVar("BastokFirstTrust")
    local zone = caster:getZoneID()

    if BastokFirstTrust == 1 and (zone == tpz.zone.NORTH_GUSTABERG or zone == tpz.zone.SOUTH_GUSTABERG) then
        caster:setCharVar("BastokFirstTrust", 2)
    end

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
            trust:useJobAbility(19, target)
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
