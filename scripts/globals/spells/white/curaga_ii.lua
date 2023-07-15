-----------------------------------
-- Spell: Curaga II
-- Restores HP of all party members within area of effect.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/spells/healing_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.healing.doHealingSpell(caster, target, spell, true)
end

return spellObject
