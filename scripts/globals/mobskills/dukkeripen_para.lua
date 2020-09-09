---------------------------------------------
-- Dukkeripen
-- paralyzes target
-- Type: Magical
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getMainJob() == tpz.job.COR then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS

    if MobStatusEffectMove(mob, target, typeEffect, 20, 0, 120) then
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    return typeEffect
end
