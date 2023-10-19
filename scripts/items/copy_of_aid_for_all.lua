-----------------------------------
-- ID: 6168
-- Item: Aid for All
-- A guide to the finer points of heightening the potential of one's compatriots, written by Rainemard.
-- It also includes some tips on how to swing special swords.
-- Adventurers note that reading it increases one's enhancing magic skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.ENHANCING_MAGIC)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.ENHANCING_MAGIC)
end

return itemObject
