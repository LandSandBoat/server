-----------------------------------------
-- ID: 5354
-- Item: Walahra Water
-- Item Effect: heals 5% mp and hp
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    -- TODO: Prevents the use of items, spells, and abilities for 5 seconds after use.
    target:addHP(target:getMaxHP() * 0.05)
    target:addMP(target:getMaxMP() * 0.05)

    target:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
end

return itemObject
