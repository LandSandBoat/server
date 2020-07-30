---------------------------------------------
-- Ichor Stream
-- Family: Hpemde
-- Description: Spews venomous ichor at targets in a fan-shaped area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Cone
-- Notes: Poison is about 5/tic.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.POISON

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 5, 0, 120))

    return typeEffect
end
