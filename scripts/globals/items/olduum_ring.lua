-----------------------------------
--   ID: 15769
--   Olduum Ring
--   Teleports to Wajoam Woodlands Leypoint
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:setPos(-199, -10, 80, 94, 51)
end

return itemObject
