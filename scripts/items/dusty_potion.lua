-----------------------------------
-- ID: 5431
-- Item: Dusty Potion
-- Item Effect: Instantly restores 300 HP
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(300 * xi.settings.main.ITEM_POWER))
end

return itemObject
