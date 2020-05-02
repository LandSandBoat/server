-----------------------------------------
-- Trust: Shantotto
-----------------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1019)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addGambit(ai.s.TARGET, ai.t.MB_AVAILABLE, 0, ai.r.MA, ai.rm.SELECT_MB_ELEMENT, tpz.magic.spellFamily.NONE)
    mob:addGambit(ai.s.TARGET, ai.t.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.rm.SELECT_HIGHEST, tpz.magic.spellFamily.NONE, 30)
end
