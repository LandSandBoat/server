---------------------------------------------
-- Lowing
--
-- Description: AoE Powerful plague
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PLAGUE
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 5, 0, 60))

    return typeEffect
end
