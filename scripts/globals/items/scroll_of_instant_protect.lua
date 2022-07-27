-----------------------------------
-- ID: 5988
--  Scroll of Instant Protect
--  Grants the effect of Protect
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = 75
    local duration = 1800

    target:addStatusEffect(xi.effect.PROTECT, power, 0, duration)
end

return item_object
