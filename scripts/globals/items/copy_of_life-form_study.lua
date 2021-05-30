-----------------------------------------
-- ID: 6177
-- Item: Life-form Study
-- A report written and filed by an anonymous individual.
-- It covers the behavioral patterns and diets of almost every known family of beasts in existence.
-- Adventurers note that reading it increases one's blue magic skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.BLUE_MAGIC)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.BLUE_MAGIC)
end

return item_object
