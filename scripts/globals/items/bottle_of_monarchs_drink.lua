-----------------------------------------
-- ID: 5393
-- Item: bottle_of_monarchs_drink
-- Item Effect: Regain
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = 3
    local duration = 180

    if (not target:hasStatusEffect(xi.effect.REGAIN)) then
        target:addStatusEffect(xi.effect.REGAIN, power, 0, duration)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
