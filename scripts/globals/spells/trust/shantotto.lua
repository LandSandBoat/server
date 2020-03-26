-----------------------------------------
-- Trust: Shantotto
-----------------------------------------
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1019)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addListener("COMBAT_TICK", "SHANTOTTO_COMBAT_TICK", function(trust, master, target)
        trust:castSpell()
    end)
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end
