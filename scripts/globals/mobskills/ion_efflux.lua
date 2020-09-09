---------------------------------------------
-- Ion_Efflux
--
-- Description: 10'(?) cone  Paralysis, ignores Utsusemi
-- Type: Magical
--
-- Range: 10 yalms
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() <= 1) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 20, 0, 60))

    return typeEffect
end
