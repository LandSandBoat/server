-----------------------------------
-- Epoxy Spread
-- AOE Bind
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30))

    return xi.effect.BIND
end

return mobskillObject
