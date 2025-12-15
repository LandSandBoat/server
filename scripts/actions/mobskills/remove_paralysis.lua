-----------------------------------
-- Remove Paralysis
-- Description: Removes Paralysis from target
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:delStatusEffect(xi.effect.PARALYSIS) then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.PARALYSIS
end

return mobskillObject
