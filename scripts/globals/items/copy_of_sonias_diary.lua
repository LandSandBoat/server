-----------------------------------------
-- ID: 6163
-- Item: Sonia's Diary
-- A compilation of memories from Sonia. Of particular note are her observations
-- on how to replicate the sheer brilliance of Annika Brilioth and the esoteric steps known as the Kriegstanz.
-- Adventurers say that reading it increases their evasion skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, tpz.skill.EVASION)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, tpz.skill.EVASION)
end

return item_object
