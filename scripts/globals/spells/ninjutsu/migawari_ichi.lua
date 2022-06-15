-----------------------------------
-- Spell: Migawari: Ichi
-- Effect Power: Damage Threshold %
-- Effect Sub Power: Damage Reduction % (In this case, 100%)
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
