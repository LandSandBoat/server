---------------------------------------------
--  Dancing Chains
--  Description:  Applies AoE drown 15hp/sec
--  Notes: Ignores shadows, 10' AoE radius
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DROWN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 15, 0, 120))
    return typeEffect
end
