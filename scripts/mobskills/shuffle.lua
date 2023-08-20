-----------------------------------
-- Shuffle
-- Dispels a single buff at random (which could be food)<-Pending verification. It does not reset hate.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effect = target:dispelStatusEffect()

    if effect == xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return effect
end

return mobskillObject
