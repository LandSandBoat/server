-----------------------------------
-- Spell: Utsusemi: Ichi
-----------------------------------
require("scripts/globals/spells/enhancing_ninjutsu")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingNinjutsu(caster, target, spell)
end

return spell_object
