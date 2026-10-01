-----------------------------------
-- Spell: Cure VI
-- Restores target's HP.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    modern =
    {
        { powerCap =    210, divisor =    1.5, constant =  600, basePower =  90 },
        { powerCap =    300, divisor =    0.9, constant =  680, basePower = 210 },
        { powerCap =    400, divisor = 10 / 7, constant =  780, basePower = 300 },
        { powerCap =    500, divisor =    2.5, constant =  850, basePower = 400 },
        { powerCap =    700, divisor =  5 / 3, constant =  890, basePower = 500 },
        { powerCap = 999999, divisor = 999999, constant = 1010, basePower =   0 },
    },
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Undead enemies take damage instead of being healed.
    if target:isUndead() and target:getAllegiance() ~= caster:getAllegiance() then
        spell:setMsg(xi.msg.basic.MAGIC_DMG)

        return xi.spells.damage.useDamageSpell(caster, target, spell)
    end

    local params =
    {
        baseCure        = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure         = 600,
        skillType       = xi.skill.HEALING_MAGIC,
        solaceStoneskin = true,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
