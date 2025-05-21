-----------------------------------
-- ID: 5414
-- Item: Glowing Lamp
-- Use: Creates a replica of the Glowing Lamp
-----------------------------------
---@type TItem

local itemObject = {}

itemObject.onItemCheck = function(target, item)
    return xi.einherjar.onLampCheck(target, item)
end

itemObject.onItemUse = function(player, target, item)
    xi.einherjar.onLampUse(player, item)
end

itemObject.onItemDrop = function(target, item)
    xi.einherjar.onLampDrop(target, item)
end

return itemObject
