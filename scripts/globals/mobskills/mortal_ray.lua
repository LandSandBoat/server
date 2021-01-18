-----------------------------------
-- Mortal Ray
--
-- Description: Inflicts Doom upon an enemy.
-- Type: Magical (Dark)
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.DOOM

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 10, 3, 30))

    return typeEffect
end

return mobskill_object
