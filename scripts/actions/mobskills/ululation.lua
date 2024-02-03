-----------------------------------
-- Ululation
-- Paralyzes all enemies in an area of effect.
--
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, math.random(18, 22), 0, 120))

    return xi.effect.PARALYSIS
end

return mobskillObject
