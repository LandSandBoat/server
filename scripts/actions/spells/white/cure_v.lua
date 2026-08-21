-----------------------------------
-- Spell: Cure V
-- Restores target's HP.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    modern =
    {
        { powerCap =    150, divisor =    0.70, constant = 450, basePower =  80 },
        { powerCap =    190, divisor =    1.25, constant = 550, basePower = 150 },
        { powerCap =    260, divisor = 70 / 38, constant = 582, basePower = 190 },
        { powerCap =    300, divisor =       2, constant = 620, basePower = 260 },
        { powerCap =    500, divisor =     2.5, constant = 640, basePower = 300 },
        { powerCap =    700, divisor =  10 / 3, constant = 720, basePower = 500 },
        { powerCap = 999999, divisor =  999999, constant = 780, basePower =   0 },
    },
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
    -- Undead enemies take damage instead of being healed.
    if target:isUndead() and target:getAllegiance() ~= caster:getAllegiance() then
        spell:setMsg(xi.msg.basic.MAGIC_DMG)

        return xi.spells.damage.useDamageSpell(caster, target, spell)
    end

    local params =
    {
        baseCure        = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure         = 450,
        skillType       = xi.skill.HEALING_MAGIC,
        solaceStoneskin = true,
        fixedCE         = 300,
        fixedVE         = 600,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
