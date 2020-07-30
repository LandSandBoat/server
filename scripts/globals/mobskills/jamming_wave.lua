---------------------------------------------
-- Jamming Wave
--
-- Description: Silence Area of Effect (16.0')
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 45))
    return typeEffect
end
