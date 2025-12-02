-----------------------------------
-- Spirit Tap
-- Attempts to absorb one buff from a single target.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Melee
-- Notes: Can be any (positive) buff, including food
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispel = mob:stealStatusEffect(target, bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    local msg -- to be set later

    if dispel == 0 then
        msg = xi.msg.basic.SKILL_NO_EFFECT -- no effect
    else
        msg = xi.msg.basic.EFFECT_DRAINED
    end

    skill:setMsg(msg)

    return 1
end

return mobskillObject
