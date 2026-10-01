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
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 559, divisor = 2.8333, constant = 391 },
        { powerFloor = 319, divisor =      1, constant = 210 },
        { powerFloor =   0, divisor = 0.6666, constant = 130 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 250,
        skillType = xi.skill.BLUE_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
