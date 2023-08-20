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
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.minCure = 60
    params.divisor0 = 0.6666
    params.constant0 = -45
    params.powerThreshold1 = 219
    params.divisor1 = 2
    params.constant1 = 65
    params.powerThreshold2 = 459
    params.divisor2 = 6.5
    params.constant2 = 144.6666

    return xi.spells.blue.useCuringSpell(caster, target, spell, params)
end

return spellObject
