-----------------------------------
-- Spell: Monomi: Ichi
-----------------------------------
require("scripts/globals/spells/enhancing_ninjutsu")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingNinjutsu(caster, target, spell)
end

return spellObject
