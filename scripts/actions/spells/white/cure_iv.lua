-----------------------------------
-- Spell: Cure IV
-- Restores target's HP.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    modern =
    {
        { powerCap =    200, divisor =      1, constant = 270, basePower =  70 },
        { powerCap =    300, divisor =      2, constant = 400, basePower = 200 },
        { powerCap =    400, divisor = 10 / 7, constant = 450, basePower = 300 },
        { powerCap =    700, divisor =    2.5, constant = 520, basePower = 400 },
        { powerCap = 999999, divisor = 999999, constant = 640, basePower =   0 },
    },
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
    -- Undead enemies take damage instead of being healed.
    if target:isUndead() and target:getAllegiance() ~= caster:getAllegiance() then
        spell:setMsg(xi.msg.basic.MAGIC_DMG)

        return xi.spells.damage.useDamageSpell(caster, target, spell)
    end

    local params =
    {
        baseCure        = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure         = 270,
        skillType       = xi.skill.HEALING_MAGIC,
        solaceStoneskin = true,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
