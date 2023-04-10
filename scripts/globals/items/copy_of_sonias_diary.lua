-----------------------------------------
-- ID: 6163
-- Item: Sonia's Diary
-- A compilation of memories from Sonia. Of particular note are her observations
-- on how to replicate the sheer brilliance of Annika Brilioth and the esoteric steps known as the Kriegstanz.
-- Adventurers say that reading it increases their evasion skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.EVASION)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.EVASION)
end

return itemObject
