-----------------------------------
-- Spell: Shell V
-----------------------------------
require("scripts/globals/spells/enhancing_spell")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    if caster:isMob() and target:hasStatusEffect(xi.effect.SHELL) then
        return 1
    else
        return 0
    end
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spell_object
