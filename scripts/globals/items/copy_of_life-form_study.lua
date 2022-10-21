-----------------------------------------
-- ID: 6177
-- Item: Life-form Study
-- A report written and filed by an anonymous individual.
-- It covers the behavioral patterns and diets of almost every known family of beasts in existence.
-- Adventurers note that reading it increases one's blue magic skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.BLUE_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.BLUE_MAGIC)
end

return itemObject
