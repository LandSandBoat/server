-----------------------------------------
-- ID: 6150
-- Item: Mieuseloir's Diary
-- An account penned by Mieuseloir B Enchelles of his encounters with the Gigas in Beaucedine Glacier.
-- Adventurers note that reading it increases one's great sword skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return item_utils.skillBookCheck(target, xi.skill.GREAT_SWORD)
end

item_object.onItemUse = function(target)
    item_utils.skillBookUse(target, xi.skill.GREAT_SWORD)
end

return item_object
