-----------------------------------
--  ID: 5264
--  Item: Yellow Liquid
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    -- TODO: Can this ONLY be used on Mammet types?
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 30, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

return itemObject
