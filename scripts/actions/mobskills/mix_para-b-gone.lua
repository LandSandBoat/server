-----------------------------------
-- Mix: Para-b-gone - Removes Paralysis.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.PARALYSIS) then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        target:delStatusEffect(xi.effect.PARALYSIS)
        return xi.effect.PARALYSIS
    else
        skill:setMsg(xi.msg.basic.NO_EFFECT)
    end
end

return mobskillObject
