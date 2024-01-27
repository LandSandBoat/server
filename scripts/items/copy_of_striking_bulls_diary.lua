-----------------------------------
-- ID: 6151
-- Item: Bull's Diary
-- An account penned by Striking Bull during the Second Battle of Konschtat.
-- It details the Republic's victory over King Raigegue the Lupine's San d'Orian army.
-- Adventurers note that reading it increases one's axe skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.AXE)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.AXE)
end

return itemObject
