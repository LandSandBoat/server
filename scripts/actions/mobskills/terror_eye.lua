-----------------------------------
-- Terror Eye
-- Family: Gargouille
-- Description: Bestows a terrifying glance.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Cone gaze
-- Notes: Only used when standing
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 4 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.TERROR, 1, 0, 30))

    return xi.effect.TERROR
end

return mobskillObject
