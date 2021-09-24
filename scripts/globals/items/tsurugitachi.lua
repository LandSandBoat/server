-----------------------------------
-- ID: 18444
-- Item: Tsurugitachi
-- Item Effect: TP +10
-- Durration: Instant
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addTP(100)
end

return item_object
