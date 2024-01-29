-----------------------------------
-- Hellsnap
-- Stuns targets in an area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 5
    local returnEffect = xi.effect.STUN
    if mob:getFamily() == 316 and mob:getLocalVar('phase') ~= 21 then
        duration = 10
    end

    skill:setMsg(xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, returnEffect, 1, 0, duration))

    return returnEffect
end

return mobskillObject
