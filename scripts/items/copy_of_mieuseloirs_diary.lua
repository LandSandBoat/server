-----------------------------------
-- ID: 6150
-- Item: Mieuseloir's Diary
-- An account penned by Mieuseloir B Enchelles of his encounters with the Gigas in Beaucedine Glacier.
-- Adventurers note that reading it increases one's great sword skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.GREAT_SWORD)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.GREAT_SWORD)
end

return itemObject
