-----------------------------------
-- ID: 6448
-- Sasu. Sh. Pouch +1
-- A small leather pouch made for storing sasuke shuriken +1.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addItem(22277, 99)
end

return itemObject
