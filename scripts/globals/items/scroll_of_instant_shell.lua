-----------------------------------
-- ID: 5989
--  Scroll of Instant Shell
--  Grants the effect of Shell
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = 1900 -- shell_iii base power
    local duration = 1800

    target:addStatusEffect(xi.effect.SHELL, power, duration)
end

return item_object
