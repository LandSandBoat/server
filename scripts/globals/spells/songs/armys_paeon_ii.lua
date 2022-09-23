-----------------------------------
-- Spell: Army's Paeon II
-- Gradually restores target's HP.
-----------------------------------
require("scripts/globals/spells/enhancing_song")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSong(caster, target, spell)
end

return spell_object
