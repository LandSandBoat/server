-----------------------------------
-- Lunar Cry
-- Fenrir gives accuracy and evasion down status effects to target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local moonCycle = getVanadielMoonCycle()

    local cycleBuffs =
    {
        [xi.moonCycle.NEW_MOON]                = 1,
        [xi.moonCycle.LESSER_WAXING_CRESCENT]  = 6,
        [xi.moonCycle.GREATER_WAXING_CRESCENT] = 11,
        [xi.moonCycle.FIRST_QUARTER]           = 16,
        [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = 21,
        [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = 26,
        [xi.moonCycle.FULL_MOON]               = 31,
        [xi.moonCycle.GREATER_WANING_GIBBOUS]  = 26,
        [xi.moonCycle.LESSER_WANING_GIBBOUS]   = 21,
        [xi.moonCycle.THIRD_QUARTER]           = 16,
        [xi.moonCycle.GREATER_WANING_CRESCENT] = 11,
        [xi.moonCycle.LESSER_WANING_CRESCENT]  = 6,
    }

    local buffValue = cycleBuffs[moonCycle]

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, buffValue, 0, 180)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 32 - buffValue, 0, 180)
    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_2)
    return 0
end

return mobskillObject
