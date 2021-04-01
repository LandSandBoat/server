-----------------------------------
-- ID: 5985
-- Item: Sprig of Hemlock
-- Food Effect: 5 Min, All Races
-- Paralysis
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(xi.effect.PARALYSIS)) then
        target:addStatusEffect(xi.effect.PARALYSIS, 20, 0, 600)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
