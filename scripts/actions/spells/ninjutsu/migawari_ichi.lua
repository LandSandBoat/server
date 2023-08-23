-----------------------------------
-- Spell: Migawari: Ichi
-- Effect Power: Damage Threshold %
-- Effect Sub Power: Damage Reduction % (In this case, 100%)
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingNinjutsu(caster, target, spell)
end

return spellObject
