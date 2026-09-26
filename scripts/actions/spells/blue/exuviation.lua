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
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 459, divisor =    6.5, constant = 144.6666 },
        { powerFloor = 219, divisor =      2, constant =       65 },
        { powerFloor =   0, divisor = 0.6666, constant =      -45 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 60,
        skillType = xi.skill.BLUE_MAGIC,
    }

    target:eraseStatusEffect()

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
