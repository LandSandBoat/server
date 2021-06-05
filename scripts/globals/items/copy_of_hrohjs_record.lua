-----------------------------------------
-- ID: 6178
-- Item: Hrohj's Record
-- A record of what happened on the fateful day the lifestream overflowed,
-- as kept by Hrohj Wagrehsa.
-- Adventurers note that reading it increases one's geomancy skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.GEOMANCY)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.GEOMANCY)
end

return item_object
