-----------------------------------
-- ID: 5432
-- Item: Dusty Ether
-- Item Effect: Instantly restores 150 MP
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_MP, 0, target:addMP(150 * xi.settings.main.ITEM_POWER))
end

return itemObject
