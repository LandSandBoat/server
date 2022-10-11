-----------------------------------
-- Meditate
-- Gives mobs regain for designated amount of time
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MEDITATE
    local duration = 15
    local power = 20

    mob:addStatusEffectEx(typeEffect, 0, power, 3, duration)
end

return mobskill_object
