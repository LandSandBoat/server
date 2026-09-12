-----------------------------------
-- Spell: Curaga IV
-- Restores HP of all party members within area of effect.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 560, divisor = 2.8333, constant = 591.2 },
        { powerFloor = 320, divisor =      1, constant =   410 },
        { powerFloor =   0, divisor = 0.6666, constant =   330 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 450,
        skillType = xi.skill.HEALING_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
