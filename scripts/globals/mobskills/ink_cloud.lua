---------------------------------------------
-- Ink Cloud
--
-- Description: Blinds nearby targets with ink.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BLINDNESS
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 15, 0, 120))

    return typeEffect
end
