-----------------------------------
-- ID: 6447
-- Sasu. Sh. Pouch
-- A small leather pouch made for storing sasuke shuriken.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addItem(22276, 99)
end


return item_object
