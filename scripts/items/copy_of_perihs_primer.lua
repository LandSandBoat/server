-----------------------------------------
-- ID: 6159
-- Item: Perih's Primer
-- A guidebook Perih Vashai jotted down for the edification of new recruits.
-- It discusses everything from the various ways of holding a bow to methods of judging distance.
-- Adventurers note that reading it increases one's archery skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.ARCHERY)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.ARCHERY)
end

return itemObject
