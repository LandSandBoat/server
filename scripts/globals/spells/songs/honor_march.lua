-----------------------------------
-- Spell: Honor March
-- Gives party members Haste, Acc, Ranged Acc, Att, Ranged Att
-----------------------------------
require("scripts/globals/magic_utils/spell_song_enhancing")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.magic_utils.spell_song_enhancing.useEnhancingSong(caster, target, spell)
end

return spell_object
