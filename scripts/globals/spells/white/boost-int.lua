-----------------------------------
-- Spell: Boost-INT
-- Boosts INT for Allies in AoE
-----------------------------------
require("scripts/globals/spells/enhancing_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spellObject
