-----------------------------------
-- Dagan
-- Family: Humanoid Club Weaponskill
-- Description: Restores HP and MP. Amount restored varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local hp = math.floor(mob:getMaxHP() * xi.mobskills.calculateDuration(skill:getTP(), 22, 52) / 100)
    local mp = math.floor(mob:getMaxMP() * xi.mobskills.calculateDuration(skill:getTP(), 15, 35) / 100)

    mob:addHP(hp)
    mob:addMP(mp)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)

    return hp
end

return mobskillObject
