-----------------------------------
-- Spell: Cure II
-- Restores target's HP.
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
        minCure         = 60,
        skillType       = xi.skill.HEALING_MAGIC,
        solaceStoneskin = true,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
