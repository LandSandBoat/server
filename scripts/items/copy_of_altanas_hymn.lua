-----------------------------------------
-- ID: 6166
-- Item: Altana's Hymn
-- A copy of Febrenard C Brunnaut's favorite read.
-- The simple lyrics and enchanting meter were said to have soothed his soul.
-- Adventurers note that reading it increases one's divine magic skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.DIVINE_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.DIVINE_MAGIC)
end

return itemObject
