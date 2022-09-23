-----------------------------------
-- Spell: Shell II
-----------------------------------
require("scripts/globals/spells/enhancing_spell")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spell_object
