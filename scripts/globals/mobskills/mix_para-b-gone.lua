-----------------------------------
-- Mix: Para-b-gone - Removes Paralysis.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.PARALYSIS) then
        target:delStatusEffect(xi.effect.PARALYSIS)
        return xi.effect.PARALYSIS
    end

    skill:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    return xi.effect.NONE
end

return mobskillObject
