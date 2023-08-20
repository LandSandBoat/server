-----------------------------------
-- Sheep Bleat
-- Emits a unnerving bleat that slows down players in range.
-- Only used by Nightmare Sheep from Dynamis-Valkurm
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1 -- The mob that uses this is not in database yet so returns 1 , when mob is added to game do a check for mob ID and return 0 if it matches nightmare sheep
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLOW
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1250, 0, 120))

    return typeEffect
end

return mobskillObject
