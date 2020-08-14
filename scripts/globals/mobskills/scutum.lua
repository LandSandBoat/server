---------------------------------------------
-- Scutum
-- Enhances defense.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, 30, 0, 120))
    return typeEffect
end
