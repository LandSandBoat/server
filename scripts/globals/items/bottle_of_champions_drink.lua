-----------------------------------------
-- ID: 5392
-- Item: bottle_of_champions_drink
-- Item Effect: Haste (Magic) 18% - CRITHITRATE 5%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effect    = xi.effect.POTENCY
    local power     = 1800  --haste
    local subpower  = 5     --crit
    local duration  = 60

    item_utils.addItemEffect(target, effect, power, duration, subpower)
end

return item_object
