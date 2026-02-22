-----------------------------------
-- ID: 4541
-- Item: Goblin Drink
-- Item Effect: Restores 1 MP while healing / 3 tick 180 mins.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.FOOD) then
        target:addStatusEffect(xi.effect.FOOD, { power = 1, duration = 10800, origin = user, tick = 3, subType = 4541 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

itemObject.onEffectGain = function(target, effect)
end

itemObject.onEffectTick = function(target, effect)
    if target:hasStatusEffect(xi.effect.HEALING) then
        target:addMP(effect:getPower())
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
