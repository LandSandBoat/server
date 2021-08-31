-----------------------------------
--   ID: 15769
--   Olduum Ring
--   Teleports to Wajoam Woodlands Leypoint
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:setPos(-199, -10, 80, 94, 51)
end

return item_object
