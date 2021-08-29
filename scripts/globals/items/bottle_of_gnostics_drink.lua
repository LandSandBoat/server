-----------------------------------------
-- ID: 5394
-- Item: bottle_of_gnostics_drink
-- Item Effect: Enmity -
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = -10   -- Power Level unknown, using Animus Minueo Value as baseline.
    local duration = 60

    if (not target:hasStatusEffect(xi.effect.PAX)) then
        target:addStatusEffect(xi.effect.PAX, power, 0, duration)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
