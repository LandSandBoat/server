-----------------------------------
-- Spell: Klimaform
-- Increases magic accuracy for spells of the same element as current weather
-----------------------------------
local spell_object = {}

require("scripts/globals/status")

spell_object.onMagicCastingCheck = function(caster, target, spell)

    return 0

end



spell_object.onSpellCast = function(caster, target, spell)

    target:addStatusEffect(xi.effect.KLIMAFORM, 1, 0, 180)

    return xi.effect.KLIMAFORM
end

return spell_object
