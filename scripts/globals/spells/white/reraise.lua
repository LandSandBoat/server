-----------------------------------
-- Spell: Reraise
-----------------------------------
local spellObject = {}

require("scripts/globals/status")

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --duration = 1800
    target:addStatusEffect(xi.effect.RERAISE, 1, 0, 3600) --reraise 1, 30min duration

    return xi.effect.RERAISE
end

return spellObject
