-----------------------------------
-- Spell: Absorb-STR
-- Steals an enemy's strength.
-----------------------------------
require("scripts/globals/spells/absorb_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.absorb.useStatAbsorb(caster, target, spell)
end

return spellObject
