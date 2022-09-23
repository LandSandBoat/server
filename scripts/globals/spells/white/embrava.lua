-----------------------------------
-- Spell: Embrava
-- Consumes 20% of your maximum MP.
-- Gradually restores target party member's HP and MP and increases attack speed.
-----------------------------------
require("scripts/globals/spells/spell_enhancing")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.spell_enhancing.useEnhancingSpell(caster, target, spell)
end

return spell_object
