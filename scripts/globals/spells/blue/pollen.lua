-----------------------------------
-- Spell: Pollen
-- Restores HP
-- Spell cost: 8 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Light)
-- Blue Magic Points: 1
-- Stat Bonus: CHR+1, HP+5
-- Level: 1
-- Casting Time: 2 seconds
-- Recast Time: 5 seconds
-----------------------------------
-- Combos: Resist Sleep
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.minCure = 14
    params.divisor0 = 1
    params.constant0 = -6
    params.powerThreshold1 = 59
    params.divisor1 = 2
    params.constant1 = 9
    params.powerThreshold2 = 99
    params.divisor2 = 57
    params.constant2 = 33.125

    return xi.spells.blue.useCuringSpell(caster, target, spell, params)
end

return spellObject
