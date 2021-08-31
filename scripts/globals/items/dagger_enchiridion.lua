-----------------------------------------
-- ID: 6148
-- Item: Dagger enchiridion
-- A guide to the finer points of wielding a dagger,
-- written by an anonymous individual.
-- Adventurers note that reading it increases one's dagger skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.DAGGER)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.DAGGER)
end

return item_object
