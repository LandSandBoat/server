-----------------------------------
-- Spell: Healing Breeze
-- Restores HP for party members within area of effect
-- Spell cost: 55 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+2, HP+10
-- Level: 16
-- Casting Time: 4.5 seconds
-- Recast Time: 15 seconds
-----------------------------------
-- Combos: Auto Regen
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/spells/healing_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.healing.doHealingSpell(caster, target, spell, false)
end

return spellObject
