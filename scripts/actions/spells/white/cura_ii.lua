-----------------------------------
-- Spell: Cura II
-- Restores HP in area of effect. Self target only.
-- Base potency is the same as Cure II's. With Afflatus Misery bonus, it can be as potent as a Curaga III.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    modern =
    {
        { powerCap =     70, divisor =      1, constant =  60, basePower =  40 },
        { powerCap =    125, divisor =    5.5, constant =  90, basePower =  70 },
        { powerCap =    200, divisor =    7.5, constant = 100, basePower = 125 },
        { powerCap =    400, divisor =     10, constant = 110, basePower = 200 },
        { powerCap =    700, divisor =     20, constant = 130, basePower = 400 },
        { powerCap = 999999, divisor = 999999, constant = 145, basePower =   0 },
    },
    old =
    {
        { powerFloor = 170, divisor = 35.6666, constant = 87.62 },
        { powerFloor = 110, divisor =       2, constant =  47.5 },
        { powerFloor =   0, divisor =       1, constant =    20 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:getID() ~= target:getID() then
        return xi.msg.basic.CANNOT_PERFORM_TARG
    else
        return 0
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 60,
        skillType = xi.skill.HEALING_MAGIC,
        miseryCap = 375,
        fixedCE   = 75,
        fixedVE   = 75,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
