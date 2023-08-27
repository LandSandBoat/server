-----------------------------------
-- Inspirit
-- Restores HP to nearby allies.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    -- Todo: verify/correct maths
    return xi.mobskills.mobHealMove(mob, math.floor(mob:getHP() / 7) * 2)
end

return mobskillObject
