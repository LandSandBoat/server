-----------------------------------
-- Ion_Efflux
-- Description: 10'(?) cone  Paralysis, ignores Utsusemi
-- Type: Magical
-- Range: 10 yalms
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 60))

    return typeEffect
end

return mobskillObject
