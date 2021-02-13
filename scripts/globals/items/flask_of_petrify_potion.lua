-----------------------------------
-- ID: 4160
-- Item: Petrify Potion
-- Item Effect: This potion induces petrify.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.PETRIFICATION)) then
        target:addStatusEffect(tpz.effect.PETRIFICATION, 1, 3, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
