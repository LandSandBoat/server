-----------------------------------
-- Myrkr
-- Family: Humanoid Staff Weaponskill
-- Description: Restores MP. Amount restored varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local amount = math.floor(xi.mobskills.calculateDuration(skill:getTP(), 20, 60) * mob:getMaxMP() / 100)

    mob:addMP(amount)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)

    return amount
end

return mobskillObject
