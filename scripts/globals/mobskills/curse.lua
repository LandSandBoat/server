---------------------------------------------
-- Curse
--
-- Description: Inflicts a curse on all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 15' radial
-- Notes: Curse has a very long duration.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CURSE_I

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 25, 0, 480))

    return typeEffect
end
