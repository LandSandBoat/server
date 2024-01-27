-----------------------------------
-- ID: 4125
-- Item: Soothing Potion
-- Item Effect: Restores 250 HP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getHP() == target:getMaxHP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(250 * xi.settings.main.ITEM_POWER))
end

return itemObject
