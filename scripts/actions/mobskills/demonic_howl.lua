-----------------------------------
-- Demonic Howl
-- 10' AoE +50%. Slow (weaker than Haste)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 120))

    return xi.effect.SLOW
end

return mobskillObject
