-----------------------------------
-- ID: 6499
-- Item: Patio design plan document
-- Grants keyitem: MOG_PATIO_DESIGN_DOCUMENT
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    -- TODO: The error message returned by this is wrong
    return target:hasKeyItem(xi.keyItem.MOG_PATIO_DESIGN_DOCUMENT) and 1 or 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveKeyItem(target, xi.keyItem.MOG_PATIO_DESIGN_DOCUMENT)
end

return itemObject
