-----------------------------------------
-- ID: 6153
-- Item: Ludwig's Report
-- A report made by Ludwig Eichberg regarding the Battle of Grauberg.
-- It details the constant changes in the position of the front line and the withdrawal of Republic troops.
-- Adventurers note that reading it increases one's scythe skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.SCYTHE)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.SCYTHE)
end

return itemObject
