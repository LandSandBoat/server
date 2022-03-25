-----------------------------------
-- Spell: Comet
-----------------------------------
require("scripts/globals/spells/spell_damage")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    -- TODO: Code succesive spell use enhancement. Method still undecided.
    return xi.spells.spell_damage.useDamageSpell(caster, target, spell)
end

return spell_object
