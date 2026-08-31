-----------------------------------
-- Spell: Cura
-- Restores HP in area of effect. Self target only.
-- Base potency is the same as Cure's. With Afflatus Misery bonus, it can be as potent as a Curaga II.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    modern =
    {
        { powerCap =     20, divisor =      4, constant = 10, basePower =   0 },
        { powerCap =     40, divisor = 1.3333, constant = 15, basePower =  20 },
        { powerCap =    125, divisor =    8.5, constant = 30, basePower =  40 },
        { powerCap =    200, divisor =     15, constant = 40, basePower = 125 },
        { powerCap =    600, divisor =     20, constant = 40, basePower = 200 },
        { powerCap = 999999, divisor = 999999, constant = 65, basePower =   0 },
    },
    old =
    {
        { powerFloor = 100, divisor = 57, constant = 29.125 },
        { powerFloor =  60, divisor =  2, constant =      5 },
        { powerFloor =   0, divisor =  1, constant =    -10 },
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
        minCure   = 10,
        skillType = xi.skill.HEALING_MAGIC,
        miseryCap = 175,
        fixedCE   = 50,
        fixedVE   = 50,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
