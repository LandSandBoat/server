-----------------------------------
-- ID: 4161
-- Item: Sleeping Potion
-- Item Effect: This potion induces sleep.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, 30)
end


return item_object
