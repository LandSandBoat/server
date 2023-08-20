-----------------------------------
-- Spell: Magic Fruit
-- Restores HP for the target party member
-- Spell cost: 72 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+1 HP+5
-- Level: 58
-- Casting Time: 3.5 seconds
-- Recast Time: 6 seconds
-----------------------------------
-- Combos: Resist Sleep
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.minCure = 250
    params.divisor0 = 0.6666
    params.constant0 = 130
    params.powerThreshold1 = 319
    params.divisor1 = 1
    params.constant1 = 210
    params.powerThreshold2 = 559
    params.divisor2 = 2.8333
    params.constant2 = 391

    return xi.spells.blue.useCuringSpell(caster, target, spell, params)
end

return spellObject
