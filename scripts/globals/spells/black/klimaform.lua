-----------------------------------
-- Spell: Klimaform
-- Increases magic accuracy for spells of the same element as current weather
-----------------------------------
local spellObject = {}

require("scripts/globals/status")

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    target:addStatusEffect(xi.effect.KLIMAFORM, 1, 0, 180)

    return xi.effect.KLIMAFORM
end

return spellObject
