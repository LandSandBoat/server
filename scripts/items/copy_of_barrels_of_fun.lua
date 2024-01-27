-----------------------------------
-- ID: 6160
-- Item: Barrels of Fun
-- An educational text authored by Elivira Gogol.
-- It discusses how to dismantle, clean, and reconstruct firearms in careful detail.
-- Adventurers note that reading it increases one's marksmanship skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.MARKSMANSHIP)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.MARKSMANSHIP)
end

return itemObject
