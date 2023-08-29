-----------------------------------
-- Scissor Guard
-- Enhances defense 100%.
-- Power: Base defense (i.e. defense bonus defense excluded) * 2
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 100, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
