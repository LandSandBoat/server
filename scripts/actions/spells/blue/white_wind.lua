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

local cureTiers =
{
    old =
    {
        { powerFloor = 0, divisor = 6.5, constant = 144.6666 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Need to confirm increases by Divine Seal and Cure Potency equipment
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = math.floor(caster:getMaxHP() / 7) * 2,
        skillType = xi.skill.BLUE_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
