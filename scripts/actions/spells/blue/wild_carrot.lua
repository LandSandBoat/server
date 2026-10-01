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
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 299, divisor = 15.6666, constant = 170.43 },
        { powerFloor = 179, divisor =       2, constant =    105 },
        { powerFloor =   0, divisor =       1, constant =     60 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 120,
        skillType = xi.skill.BLUE_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
