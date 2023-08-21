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

    target:eraseStatusEffect()
    return xi.spells.blue.useCuringSpell(caster, target, spell, params)
end

return spellObject
