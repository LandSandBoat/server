-----------------------------------
-- Starlight
-- Family: Humanoid Club Weaponskill
-- Description: Restores MP. Amount restored varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local skillLevel = mob:getMaxSkillLevel(math.min(mob:getMainLvl(), 99), mob:getMainJob(), xi.skill.CLUB) or 0
    local amount     = math.floor(((skillLevel - 10) / 9) * (skill:getTP() / 1000))

    mob:addMP(amount)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)

    return amount
end

return mobskillObject
