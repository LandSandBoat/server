-----------------------------------
-- Spell: Dark Carol
-- Increases dark resistance for party members within the area of effect.
-----------------------------------
require("scripts/globals/spells/enhancing_song")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSong(caster, target, spell)
end

return spellObject
