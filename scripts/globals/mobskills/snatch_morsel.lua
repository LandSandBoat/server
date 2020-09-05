---------------------------------------------
-- Snatch Morsel
-- Steals food effect
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if (target:hasStatusEffect(tpz.effect.FOOD)) then
        -- 99% sure retail doesn't do this. Uncomment if you want it to happen.
        -- local FOOD_ID = target:getStatusEffect(tpz.effect.FOOD):getSubType()
        -- local DURATION = target:getStatusEffect(tpz.effect.FOOD):getDuration()
        -- mob:addStatusEffect(tpz.effect.FOOD, 0, 0, DURATION, FOOD_ID) -- Gives Colibri the players food.
        target:delStatusEffect(tpz.effect.FOOD)
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
    elseif (target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        -- 99% sure retail doesn't do this. Uncomment if you want it to happen.
        -- local FOOD_ID = target:getStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD):getpower()
        -- local DURATION = target:getStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD):getDuration()
        -- mob:addStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD, FOOD_ID, 0, DURATION) -- Gives Colibri the players FoV/GoV food.
        target:delStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
    end

    return tpz.effect.FOOD
end
