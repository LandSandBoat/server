-----------------------------------
-- Mix: Dry Ether Concoction - Restores 160 MP to a single party member.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)
    target:addMP(160)
    return 0
end

return mobskillObject
