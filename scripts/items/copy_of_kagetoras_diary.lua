-----------------------------------
-- ID: 6155
-- Item: Kagetora's Diary
-- A diary written by Kagetora.
-- In it he details each and every one of his ninety-eight victories and ninety-nine losses against Yomi.
-- Adventurers note that reading it increases one's katana skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.KATANA)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.KATANA)
end

return itemObject
