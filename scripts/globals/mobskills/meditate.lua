-----------------------------------
-- Meditate
-- Gives mobs regain for designated amount of time
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MEDITATE
    local duration = 15
    local power = 20

    mob:addStatusEffectEx(typeEffect, 0, power, 3, duration)
end

return mobskillObject
