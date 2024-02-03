-----------------------------------
-- Sand Shield
-- Enhances defense.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 50, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
