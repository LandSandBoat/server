-----------------------------------
-- ID: 6172
-- Item: Breezy Libretto
-- A musical score composed by Lewenhart.
-- Its notes symbolize a fragrant, early morning summer breeze.
-- Adventurers note that reading it increases one's singing skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.SINGING)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.SINGING)
end

return itemObject
