-----------------------------------
-- Slumber Powder
-- 10' AoE sleep
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.random(15, 20) + mob:getMainLvl() / 4

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, power))

    return xi.effect.SLEEP_I
end

return mobskillObject
