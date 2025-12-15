-----------------------------------
-- Ion_Efflux
-- Description: 10'(?) cone  Paralysis, ignores Utsusemi
-- Type: Magical
-- Range: 10 yalms
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 180))

    return xi.effect.PARALYSIS
end

return mobskillObject
