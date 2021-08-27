-----------------------------------
-- Snatch Morsel
-- Steals food effect
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if (target:hasStatusEffect(xi.effect.FOOD)) then
        -- 99% sure retail doesn't do this. Uncomment if you want it to happen.
        -- local FOOD_ID = target:getStatusEffect(xi.effect.FOOD):getSubType()
        -- local DURATION = target:getStatusEffect(xi.effect.FOOD):getDuration()
        -- mob:addStatusEffect(xi.effect.FOOD, 0, 0, DURATION, FOOD_ID) -- Gives Colibri the players food.
        target:delStatusEffect(xi.effect.FOOD)
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    elseif (target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)) then
        -- 99% sure retail doesn't do this. Uncomment if you want it to happen.
        -- local FOOD_ID = target:getStatusEffect(xi.effect.FIELD_SUPPORT_FOOD):getpower()
        -- local DURATION = target:getStatusEffect(xi.effect.FIELD_SUPPORT_FOOD):getDuration()
        -- mob:addStatusEffect(xi.effect.FIELD_SUPPORT_FOOD, FOOD_ID, 0, DURATION) -- Gives Colibri the players FoV/GoV food.
        target:delStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS) -- no effect
    end

    return xi.effect.FOOD
end

return mobskill_object
