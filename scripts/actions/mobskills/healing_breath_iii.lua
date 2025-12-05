-----------------------------------
-- Healing Breath III
-- Description: Restores HP for target
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local curePower = 60 + math.floor(mob:getMaxHP() * 63 / 256)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, curePower)
end

return mobskillObject
