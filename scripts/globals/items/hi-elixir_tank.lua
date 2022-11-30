-----------------------------------
-- ID: 26271
-- Hi-Elixir Tank
-- When used, you will obtain one hi-elixir
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
    target:addItem(4144, 1)
end

return itemObject
