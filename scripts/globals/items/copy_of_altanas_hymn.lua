-----------------------------------------
-- ID: 6166
-- Item: Altana's Hymn
-- A copy of Febrenard C Brunnaut's favorite read.
-- The simple lyrics and enchanting meter were said to have soothed his soul.
-- Adventurers note that reading it increases one's divine magic skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.DIVINE_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.DIVINE_MAGIC)
end

return item_object
