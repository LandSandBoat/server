-----------------------------------
-- Barrage
-- Fires multiple shots at once.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:addStatusEffect(xi.effect.BARRAGE, 0, 0, 60)
    return 0
end

return mobskillObject
