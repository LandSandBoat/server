-----------------------------------
-- ID: 4118
-- Item: Hi-Potion +2
-- Item Effect: Restores 120 HP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getHP() == target:getMaxHP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(120 * xi.settings.main.ITEM_POWER))
end

return itemObject
