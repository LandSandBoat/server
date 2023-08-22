---------------------------------------------
-- Fantod
-- Hippogryph Boost Ability.
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, 300, 0, 180))

    return xi.effect.BOOST
end

return mobskillObject
