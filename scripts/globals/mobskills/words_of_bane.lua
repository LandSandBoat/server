---------------------------------------------
--  Words of Bane
--
--  Description: Curses a single target.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Single Target
--  Notes:
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

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 25, 0, 360))

    return typeEffect
end
