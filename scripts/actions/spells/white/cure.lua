-----------------------------------
-- Spell: Cure
-- Restores target's HP.
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
        minCure         = 10,
        skillType       = xi.skill.HEALING_MAGIC,
        solaceStoneskin = true,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
