-----------------------------------
-- Spell: Enchanting Etude
-- Static CHR Boost, BRD 22
-----------------------------------
require("scripts/globals/magic_utils/spell_song")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.magic_utils.spell_song.useEnhancingSong(caster, target, spell)
end

return spell_object
