-----------------------------------------
-- ID: 6151
-- Item: Bull's Diary
-- An account penned by Striking Bull during the Second Battle of Konschtat.
-- It details the Republic's victory over King Raigegue the Lupine's San d'Orian army.
-- Adventurers note that reading it increases one's axe skill.
-----------------------------------------
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.item_utils.skillBookCheck(target, xi.skill.AXE)
end

itemObject.onItemUse = function(target)
    xi.item_utils.skillBookUse(target, xi.skill.AXE)
end

return itemObject
