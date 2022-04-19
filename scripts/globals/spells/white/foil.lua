-----------------------------------
-- Spell: Foil
-----------------------------------
require("scripts/globals/spells/spell_enhancing")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

-- TODO: determine mechanics of how Foil's "Special Attack" evasion works.
-- Martel has a post about it here: https://www.bluegartr.com/threads/115399-Rune-Fencer-Findings?p=5665305&viewfull=1#post5665305
-- More testing is required (such as determining accuracy of the target used for testing)
spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.spell_enhancing.useEnhancingSpell(caster, target, spell)
end

return spell_object
