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
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 99, divisor = 57, constant = 33.125 },
        { powerFloor = 59, divisor =  2, constant =      9 },
        { powerFloor =  0, divisor =  1, constant =     -6 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 14,
        skillType = xi.skill.BLUE_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
