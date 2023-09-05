-----------------------------------
-- ID: 4157
-- Item: Cursed Beverage
-- Item Effect: Removes 25 HP over 180 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.POISON) then
        target:addStatusEffect(xi.effect.POISON, 25, 3, 180)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
