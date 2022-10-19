-----------------------------------
-- Spell: Reraise 4
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --duration = 1800
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, 4, 0, 3600) --reraise 3, 30min duration

    return xi.effect.RERAISE
end

return spellObject
