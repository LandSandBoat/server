-----------------------------------
-- ID: 5827
-- Item: Lucid Ether I
-- Item Effect: Restores 250 MP
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getMP() == target:getMaxMP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_MP, 0, target:addMP(250 * xi.settings.main.ITEM_POWER))
end

return itemObject
