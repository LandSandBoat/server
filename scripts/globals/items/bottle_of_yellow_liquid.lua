-----------------------------------
--  ID: 5264
--  Item: Yellow Liquid
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0

    if (target:hasStatusEffect(tpz.effect.FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end

    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 30, 5264)
end

return item_object
