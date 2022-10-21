-----------------------------------
-- Spell: Embrava
-- Consumes 20% of your maximum MP.
-- Gradually restores target party member's HP and MP and increases attack speed.
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
