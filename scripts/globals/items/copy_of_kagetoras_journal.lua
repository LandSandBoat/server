-----------------------------------------
-- ID: 6165
-- Item: Kage. Journal
-- A journal kept by Kagetora that delineates the extent to which
-- he and Yomi lost themselves in their studies of the martial arts
-- Adventurers note that reading it increases one's parrying skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.PARRY)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.PARRY)
end

return itemObject
