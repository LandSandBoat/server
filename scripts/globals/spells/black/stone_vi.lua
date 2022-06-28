-----------------------------------
-- Spell: Stone VI
-----------------------------------
require("scripts/globals/spells/damage_spell")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spell_object
