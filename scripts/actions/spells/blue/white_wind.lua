-----------------------------------
-- Spell: White Wind
-- Restores HP of all party members within area of effect.
-- Spell cost: 145 MP
-- Monster Type: Dragon
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 5
-- Stat Bonus: HP+5 AGI+1
-- Level: 94
-- Casting Time: 7 seconds
-- Recast Time: 20 seconds
-----------------------------------
-- Combos: Auto Regen
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Need to confirm increases by Divine Seal and Cure Potency equipment
    local params = {}
    params.minCure = math.floor(caster:getMaxHP() / 7) * 2
    params.divisor0 = 0.6666
    params.constant0 = -45
    params.powerThreshold1 = 0
    params.divisor1 = 2
    params.constant1 = 65
    params.powerThreshold2 = 0
    params.divisor2 = 6.5
    params.constant2 = 144.6666

    return xi.spells.blue.useCuringSpell(caster, target, spell, params)
end

return spellObject
