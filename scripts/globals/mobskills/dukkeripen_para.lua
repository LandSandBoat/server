-----------------------------------
-- Dukkeripen
-- paralyzes target
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
    local typeEffect = xi.effect.PARALYSIS

    if MobStatusEffectMove(mob, target, typeEffect, 20, 0, 120) then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskill_object
