---------------------------------------------
-- Eternal Damnation
-- Description: Inflicts Doom upon an enemy.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobGazeMove(mob, target, tpz.effect.DOOM, 10, 3, 30))

    return tpz.effect.DOOM
end
