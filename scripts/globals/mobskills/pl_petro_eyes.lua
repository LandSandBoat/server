---------------------------------------------
-- Petro Eyes
-- Description: Petrifies opponents with a gaze attack.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Single gaze
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 421) then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.PETRIFICATION

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 30))
    return typeEffect
end

return mobskill_object
