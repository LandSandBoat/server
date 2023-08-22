-----------------------------------
-- Sheep Song
-- 15' AoE sleep
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 45))

    return xi.effect.SLEEP_I
end

return mobskillObject
