-----------------------------------
-- ID: 4166
-- Deodorizer
-- When applied, this powerful deodorant neutralizes even the strongest of odors!!.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(xi.effect.DEODORIZE)) then
        target:addStatusEffect(xi.effect.DEODORIZE, 1, 10, 180)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
