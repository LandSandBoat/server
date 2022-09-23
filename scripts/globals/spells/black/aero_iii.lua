-----------------------------------
-- Spell: Aero III
-----------------------------------
require("scripts/globals/spells/spell_damage")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.spell_damage.useDamageSpell(caster, target, spell)
end

return spell_object
