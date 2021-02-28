-----------------------------------------
-- ID: 6168
-- Item: Aid for All
-- A guide to the finer points of heightening the potential of one's compatriots, written by Rainemard.
-- It also includes some tips on how to swing special swords.
-- Adventurers note that reading it increases one's enhancing magic skill. 
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.ENHANCING_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.ENHANCING_MAGIC)
end

return item_object
