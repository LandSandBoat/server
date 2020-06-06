-----------------------------------------
-- Trust: Ajido-Marujido
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/gambits")
require("scripts/globals/status")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0,
                        ai.r.MA, ai.s.MB_ELEMENT, tpz.magic.spellFamily.NONE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.SLOW,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SLOW, 60)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.NONE, 30)
end

function onMobDespawn(mob)
end

function onMobDeath(mob)
end
