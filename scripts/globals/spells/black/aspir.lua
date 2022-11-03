-----------------------------------
-- Spell: Aspir
-- Aspir functions only on Dark Magic skill level!
-----------------------------------
require("scripts/globals/spells/absorb_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.absorb.useAspirSpell(caster, target, spell)
end

return spellObject
