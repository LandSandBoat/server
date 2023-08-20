-----------------------------------------
-- ID: 6175
-- Item: Yomi's Diagram
-- A meticulously drawn diagram Yomi made for Kagetora explaining how to construct certain ninja tools.
-- Adventurers note that reading it increases one's ninjutsu skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.NINJUTSU)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.NINJUTSU)
end

return itemObject
