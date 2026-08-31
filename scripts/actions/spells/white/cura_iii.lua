-----------------------------------
-- Spell: Cura III
-- Restores HP in area of effect. Self target only.
-- Base potency is the same as Cure III's. With Afflatus Misery bonus, it can be as potent as a Curaga IV.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    modern =
    {
        { powerCap =    125, divisor =     2.2, constant = 130, basePower =  70 },
        { powerCap =    200, divisor = 75 / 65, constant = 155, basePower = 125 },
        { powerCap =    300, divisor =     2.5, constant = 220, basePower = 200 },
        { powerCap =    700, divisor =       5, constant = 260, basePower = 300 },
        { powerCap = 999999, divisor =  999999, constant = 340, basePower =   0 },
    },
    old =
    {
        { powerFloor = 300, divisor = 15.6666, constant = 180.43 },
        { powerFloor = 180, divisor =       2, constant =    115 },
        { powerFloor =   0, divisor =       1, constant =     70 },
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
        minCure   = 130,
        skillType = xi.skill.HEALING_MAGIC,
        miseryCap = 675,
        fixedCE   = 100,
        fixedVE   = 100,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
