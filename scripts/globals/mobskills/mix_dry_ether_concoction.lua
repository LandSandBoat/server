-----------------------------------
-- Mix: Dry Ether Concoction - Restores 160 MP to a single party member.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)
    target:addMP(160)
    return 0
end

return mobskill_object
