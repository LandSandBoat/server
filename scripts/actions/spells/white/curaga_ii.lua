-----------------------------------
-- Spell: Curaga II
-- Restores HP of all party members within area of effect.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 300, divisor = 15.6666, constant = 180.43 },
        { powerFloor = 180, divisor =       2, constant =    115 },
        { powerFloor =   0, divisor =       1, constant =     70 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 130,
        skillType = xi.skill.HEALING_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
