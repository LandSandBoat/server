-----------------------------------
-- ID: 5822
-- Oberon Bullet Pouch
-- When used, you will obtain one stack of Oberon Bullets
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/items")
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
    target:addItem(xi.items.OBERON_BULLET, 99)
end

return itemObject
