-----------------------------------
-- Spell: Absorb-Attri
-- Steals an enemy's beneficial status effects.
-----------------------------------
require("scripts/globals/spells/absorb_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- TODO: Get correct animation from retail captures
    return xi.spells.absorb.useEffectAbsorb(caster, target, spell)
end

return spellObject
