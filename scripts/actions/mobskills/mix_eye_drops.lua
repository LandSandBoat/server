-----------------------------------
-- Mix: Eye Drops - Removes Blindness.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.BLINDNESS) then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        target:delStatusEffect(xi.effect.BLINDNESS)
        return xi.effect.BLINDNESS
    else
        skill:setMsg(xi.msg.basic.NO_EFFECT)
    end
end

return mobskillObject
