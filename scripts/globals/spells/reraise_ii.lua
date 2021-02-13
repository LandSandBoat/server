-----------------------------------
-- Spell: Reraise 2
-----------------------------------
local spell_object = {}

require("scripts/globals/status")

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    --duration = 1800
    target:delStatusEffect(tpz.effect.RERAISE)
    target:addStatusEffect(tpz.effect.RERAISE, 2, 0, 3600) --reraise 2, 30min duration

    return tpz.effect.RERAISE
end

return spell_object
