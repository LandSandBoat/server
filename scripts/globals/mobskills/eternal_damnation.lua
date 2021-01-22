-----------------------------------
-- Eternal Damnation
-- Description: Inflicts Doom upon an enemy.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(MobGazeMove(mob, target, tpz.effect.DOOM, 10, 3, 30))

    return tpz.effect.DOOM
end

return mobskill_object
