-----------------------------------------
-- ID: 6169
-- Item: Inv. Report
-- A collection of observations made by Rainemard on a particular exploration.
-- It goes into such detail on so much minutiae that many admit to never finishing it.
-- Adventurers note that reading it increases one's enfeebling magic skill. 
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.ENFEEBLING_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.ENFEEBLING_MAGIC)
end

return item_object
