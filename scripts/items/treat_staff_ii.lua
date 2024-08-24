-----------------------------------
--  ID: 17588
--  Treat staff II
--  Transports the user to their Home Point
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:warp()
end

return itemObject
