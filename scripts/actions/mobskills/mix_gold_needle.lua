-----------------------------------
-- Mix: Gold Needle - Removes Petrification.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.PETRIFICATION) then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        target:delStatusEffect(xi.effect.PETRIFICATION)
        return xi.effect.PETRIFICATION
    else
        skill:setMsg(xi.msg.basic.NO_EFFECT)
    end
end

return mobskillObject
