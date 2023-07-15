-----------------------------------
-- ID: 5830
-- Item: Lucid Elixir I
-- Item Effect: Restores 50% of HP and MP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if
        target:getMaxHP() == target:getHP() and
        target:getMaxMP() == target:getMP()
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addHP(target:getMaxHP() * 0.5 * xi.settings.main.ITEM_POWER)
    target:addMP(target:getMaxMP() * 0.5 * xi.settings.main.ITEM_POWER)
    target:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
end

return itemObject
