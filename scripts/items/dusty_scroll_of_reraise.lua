-----------------------------------
-- ID: 5436
-- name: dusty_scroll_of_reraise
-- effect: grants reraise III for 10m
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.RERAISE
    local power     = 3
    local duration  = 600

    xi.itemUtils.addItemEffect(target, effect, power, duration)
end

return itemObject
