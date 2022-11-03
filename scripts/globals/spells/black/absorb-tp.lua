-----------------------------------
-- Spell: Absorb-TP
-- Steals an enemy's TP.
-----------------------------------
require("scripts/globals/spells/absorb_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.absorb.useTpAbsorb(caster, target, spell)
end

return spellObject
