-----------------------------------
-- Spell: Curaga
-- Restores HP of all party members within area of effect.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 170, divisor = 35.6666, constant = 87.62 },
        { powerFloor = 110, divisor =       2, constant =  47.5 },
        { powerFloor =   0, divisor =       1, constant =    20 },
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
        skillType = xi.skill.HEALING_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
