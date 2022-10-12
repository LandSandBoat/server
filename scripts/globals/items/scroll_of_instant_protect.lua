-----------------------------------
-- ID: 5988
--  Scroll of Instant Protect
--  Grants the effect of Protect
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local power = 75
    local duration = 1800

    target:addStatusEffect(xi.effect.PROTECT, power, 0, duration)
end

return itemObject
