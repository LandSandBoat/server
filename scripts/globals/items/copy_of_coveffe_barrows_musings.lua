-----------------------------------------
-- ID: 6167
-- Item: Coveffe Musings
-- A collection of thoughts scribbled out by Ferreous Coffin on his visit to Coveffe Barrows.
-- Adventurers note that reading it increases one's healing magic skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.HEALING_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.HEALING_MAGIC)
end

return item_object
