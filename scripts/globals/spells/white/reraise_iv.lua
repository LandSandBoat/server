-----------------------------------
-- Spell: Reraise 4
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    --duration = 1800
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, 4, 0, 3600) --reraise 3, 30min duration

    return xi.effect.RERAISE
end

return spell_object
