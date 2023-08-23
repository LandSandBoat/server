-----------------------------------
-- ID: 16230
-- Item: Lieutenant's Cape
-- Item Effect: Restores 50% hp and 25% mp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addHP((target:getMaxHP() / 100) * 50)
    target:addMP((target:getMaxMP() / 100) * 25)
    target:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
end

return itemObject
