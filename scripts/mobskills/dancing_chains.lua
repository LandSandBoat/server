-----------------------------------
--  Dancing Chains
--  Description:  Applies AoE drown 15hp/sec
--  Notes: Ignores shadows, 10' AoE radius
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DROWN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 15, 0, 120))
    return typeEffect
end

return mobskillObject
