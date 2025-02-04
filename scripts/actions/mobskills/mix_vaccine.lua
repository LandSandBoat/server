-----------------------------------
-- Vaccine - Removes Plague.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.PLAGUE) then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        target:delStatusEffect(xi.effect.PLAGUE)
        return xi.effect.PLAGUE
    else
        skill:setMsg(xi.msg.basic.NO_EFFECT)
    end
end

return mobskillObject
