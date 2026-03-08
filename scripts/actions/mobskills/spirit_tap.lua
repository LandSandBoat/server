-----------------------------------
-- Spirit Tap
-- Family: Thinkers
-- Description: Attempts to absorb one buff from a single target.
-- Notes: Can be any (positive) buff, including food
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobType.NOTORIOUS) then -- TODO: Set proper skill lists.
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local dispel = mob:stealStatusEffect(target, bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    local msg -- To be set later

    if dispel == 0 then
        msg = xi.msg.basic.SKILL_NO_EFFECT -- No effect
    else
        msg = xi.msg.basic.EFFECT_DRAINED
    end

    skill:setMsg(msg)

    return 1
end

return mobskillObject
