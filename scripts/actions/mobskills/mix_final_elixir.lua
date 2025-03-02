-----------------------------------
-- Mix: Final Elixir - Restores all HP/MP to party members.
-- Used once per elixir donation. He will need a refill to use it again.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:addHP(target:getMaxHP())
    target:addMP(target:getMaxMP())
    skill:setMsg(xi.msg.basic.RECOVERS_HP_AND_MP)
    return
end

return mobskillObject
