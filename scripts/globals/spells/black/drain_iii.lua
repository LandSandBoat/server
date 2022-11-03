-----------------------------------
-- Spell: Drain III
-- Drain functions only on Dark Magic skill level!
-----------------------------------
require("scripts/globals/spells/absorb_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- TODO: Get correct animation from retail captures
    return xi.spells.absorb.useDrainSpell(caster, target, spell)
end

return spellObject
