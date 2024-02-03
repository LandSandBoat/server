-----------------------------------
-- Goblin Dice
-- Description: AoE curse.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 30, 0, 300))

    return xi.effect.CURSE_I
end

return mobskillObject
