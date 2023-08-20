-----------------------------------------
-- ID: 6157
-- Item: Ferreous's Diary
-- A diary written by Ferreous Coffin that describes his encounters with Orcs in the north.
-- So many were there that his war hammer became coated with a thick layer of blood after all was said and done.
-- Adventurers note that reading it increases one's club skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.CLUB)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.CLUB)
end

return itemObject
