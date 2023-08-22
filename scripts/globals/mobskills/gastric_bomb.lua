-----------------------------------
-- Gastric Bomb
-- Deals Water damage with a long-range acid bomb. Additional effect: Attack Down
-- Range: Long range
-- Notes: Attack Down effect is 50%.
-- Duration: Three minutes
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 180

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 50, 0, duration))

    return xi.effect.ATTACK_DOWN
end

return mobskillObject
