-----------------------------------
-- Scissor Guard
-- Enhances defense 100%.
-- Power: Base defense (i.e. defense bonus defense excluded) * 2
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
    local typeEffect = xi.effect.DEFENSE_BOOST
    local power = mob:getStat(xi.mod.DEF)

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, 60))
    return typeEffect
end

return mobskillObject
