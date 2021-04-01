-----------------------------------------
-- ID: 6153
-- Item: Ludwig's Report
-- A report made by Ludwig Eichberg regarding the Battle of Grauberg.
-- It details the constant changes in the position of the front line and the withdrawal of Republic troops.
-- Adventurers note that reading it increases one's scythe skill. 
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.SCYTHE)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.SCYTHE)
end

return item_object
