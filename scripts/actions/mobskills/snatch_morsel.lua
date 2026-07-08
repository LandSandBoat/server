-----------------------------------
-- Snatch Morsel
-- Steals food effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if target:hasStatusEffect(xi.effect.FOOD) then
        -- 99% sure retail doesn't do this. Uncomment if you want it to happen.
        -- local foodID = target:getStatusEffect(xi.effect.FOOD):getSourceTypeParam()
        -- local duration = target:getStatusEffect(xi.effect.FOOD):getDuration()
        -- mob:addStatusEffect(xi.effect.FOOD, { duration = duration, origin = mob, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = foodID }) -- Gives Colibri the players food.
        target:delStatusEffectSilent(xi.effect.FOOD)
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS) -- no effect
    end

    return xi.effect.FOOD
end

return mobskillObject
