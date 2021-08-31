-----------------------------------------
-- ID: 6152
-- Item: Death for Dimwits
-- A guide to the finer points of hacking everything in one's way to pieces with a two-handed axe,
-- written by an anonymous individual.
-- Adventurers note that reading it increases one's great axe skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.GREAT_AXE)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.GREAT_AXE)
end

return item_object
