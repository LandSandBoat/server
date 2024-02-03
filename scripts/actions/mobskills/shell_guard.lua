-----------------------------------
-- Shell Guard
-- Increases defense of user.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 100, 0, 180))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
