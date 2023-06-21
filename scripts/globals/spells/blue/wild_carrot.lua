-----------------------------------
-- Spell: Wild Carrot
-- Restores HP for the target party member
-- Spell cost: 37 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: HP+5
-- Level: 30
-- Casting Time: 2.5 seconds
-- Recast Time: 6 seconds
-----------------------------------
-- Combos: Resist Sleep
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.minCure = 120
    params.divisor0 = 1
    params.constant0 = 60
    params.powerThreshold1 = 179
    params.divisor1 = 2
    params.constant1 = 105
    params.powerThreshold2 = 299
    params.divisor2 = 15.6666
    params.constant2 = 170.43

    return xi.spells.blue.useCuringSpell(caster, target, spell, params)
end

return spellObject
