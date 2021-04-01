-----------------------------------
-- Dukkeripen
-- Self healing move
-- Type: Magical
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == xi.job.COR then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return MobHealMove(mob, math.random(350, 500))
end

return mobskill_object
