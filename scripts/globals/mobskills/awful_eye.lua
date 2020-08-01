---------------------------------------------
-- Awful Eye
-- 15' Reduces STR of players in area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STR_DOWN

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 33, 3, 120))
    return typeEffect
end
