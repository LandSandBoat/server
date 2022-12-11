-----------------------------------
-- Spell: Exuviation
-- Restores HP and removes one detrimental magic effect
-- Spell cost: 40 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 4
-- Stat Bonus: HP+5 MP+5 CHR+1
-- Level: 75
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-----------------------------------
-- Combos: Resist Sleep
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
    target:eraseStatusEffect()
    spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

    return xi.spells.healing.doHealingSpell(caster, target, spell, false)
end

return spellObject
