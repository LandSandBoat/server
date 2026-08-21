-----------------------------------
-- Spell: Curaga III
-- Restores HP of all party members within area of effect.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 460, divisor =    6.5, constant = 354.6666 },
        { powerFloor = 220, divisor =      2, constant =      275 },
        { powerFloor =   0, divisor = 0.6666, constant =      165 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 270,
        skillType = xi.skill.HEALING_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
