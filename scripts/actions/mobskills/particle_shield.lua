-----------------------------------
-- Particle Shield
--
-- Description: Enhances defense.
-- Type: Magical
-- Notes: Ultima only.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 100, 0, 300))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
