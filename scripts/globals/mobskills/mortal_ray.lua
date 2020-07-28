---------------------------------------------
-- Mortal Ray
--
-- Description: Inflicts Doom upon an enemy.
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DOOM

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 10, 3, 30))

    return typeEffect
end
