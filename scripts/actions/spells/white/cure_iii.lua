-----------------------------------
-- Spell: Cure III
-- Restores target's HP.
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
        minCure         = 130,
        skillType       = xi.skill.HEALING_MAGIC,
        solaceStoneskin = true,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
