-----------------------------------
-- Chemical_Bomb
-- Description: slow + elegy
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ELEGY, 5000, 0, 120))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 120))

    -- This likely doesn't behave like retail.
    return xi.effect.SLOW
end

return mobskillObject
