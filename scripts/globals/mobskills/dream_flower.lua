-----------------------------------
-- Dream Flower
-- 15' AoE sleep
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 60

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration))

    return xi.effect.SLEEP_I
end

return mobskillObject
