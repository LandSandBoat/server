-----------------------------------
-- Sonic Wave
-- Reduces defense of enemies in an area of effect.
-- Defense down should be 40% with a random duration between 2.5 minutes to 3 minutes.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 40, 0, math.random(150, 180)))

    return xi.effect.DEFENSE_DOWN
end

return mobskillObject
