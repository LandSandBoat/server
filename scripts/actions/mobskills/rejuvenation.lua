-----------------------------------
-- Rejuvenation
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local hp = target:getMaxHP() - target:getHP()
    target:addHP(hp)
    target:addMP(target:getMaxMP() - target:getMP())
    target:addTP(3000 - target:getTP())

    skill:setMsg(xi.msg.basic.USES_SKILL_RECOVERS_HP_AREA_OF_EFFECT)
    return hp
end

return mobskillObject
