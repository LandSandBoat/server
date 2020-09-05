---------------------------------------------
-- Apocalyptic Ray
-- Only used by Eldertaur
-- Description: Inflicts Doom upon an enemy. This is not a gaze attack. Turing away will not prevent doom.
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.DOOM, 10, 3, 30))

    return tpz.effect.DOOM
end
