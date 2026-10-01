-----------------------------------
-- Spell: Curaga V
-- Restores HP of all party members within area of effect.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        -- Capture needed
        { powerFloor = 780, divisor = 2.667, constant = 814 },
        { powerFloor =   0, divisor =     1, constant = 570 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 600,
        skillType = xi.skill.HEALING_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
