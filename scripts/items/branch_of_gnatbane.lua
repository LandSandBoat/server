-----------------------------------
-- ID: 5984
-- Item: Branch of Gnatbane
-- Food Effect: 10 Mins, All Races
-- Poison 10HP / 3Tic
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 600, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
    if not target:hasStatusEffect(xi.effect.POISON) then
        target:addStatusEffect(xi.effect.POISON, { power = 10, duration = 600, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
