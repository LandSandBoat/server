-----------------------------------------
-- ID: 6156
-- Item: Noillurie's Log
-- A record Noillurie kept of her personal experiences.
-- The one that stands out the most is the battle with the colossal beast she undertook to prove herself to her order.
-- Adventurers note that reading it increases one's great katana skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.GREAT_KATANA)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.GREAT_KATANA)
end

return itemObject
