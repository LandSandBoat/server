-----------------------------------
-- Sonic Wave
-- Reduces defense of enemies in an area of effect.
-- Defense down should be 40% with a random duration between 2.5 minutes to 3 minutes.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 120))

    return typeEffect
end

return mobskillObject
