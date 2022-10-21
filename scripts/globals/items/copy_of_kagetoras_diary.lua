-----------------------------------------
-- ID: 6155
-- Item: Kagetora's Diary
-- A diary written by Kagetora.
-- In it he details each and every one of his ninety-eight victories and ninety-nine losses against Yomi.
-- Adventurers note that reading it increases one's katana skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.KATANA)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.KATANA)
end

return itemObject
