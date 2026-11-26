-----------------------------------
-- Benediction
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    target:eraseAllStatusEffect()

    local maxHeal = target:getMaxHP() - target:getHP()

    target:addHP(maxHeal)
    target:wakeUp()

    skill:setMsg(xi.msg.basic.USES_SKILL_RECOVERS_HP_AREA_OF_EFFECT)

    return maxHeal
end

return mobskillObject
