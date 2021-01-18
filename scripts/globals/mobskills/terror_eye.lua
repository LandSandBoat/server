---------------------------------------------
-- Terror Eye
-- Family: Gargouille
-- Description: Bestows a terrifying glance.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Cone gaze
-- Notes: Only used when standing
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getAnimationSub() ~=0) then
        return 1
    else
        return 0
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local duration = 30

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end

return mobskill_object
