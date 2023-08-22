-----------------------------------
-- ID: 5439
-- Item: bottle_of_vicars_drink
-- Item Effect: Instantly removes all negative status effects from target
--              Does not remove Plague or Curse
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effects = xi.item_utils.removableEffects
    local count = 33

    xi.item_utils.removeMultipleEffects(target, effects, count)
end

return itemObject
