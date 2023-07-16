-----------------------------------
-- ID: 5944
-- Item: Bottle of Frontier Soda
-- Item Effect: Restores 20 TP over 60 seconds.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REGAIN) then
        target:addStatusEffect(xi.effect.REGAIN, 1, 3, 60)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
