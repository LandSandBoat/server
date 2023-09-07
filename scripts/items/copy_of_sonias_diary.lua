-----------------------------------
-- ID: 6163
-- Item: Sonia's Diary
-- A compilation of memories from Sonia. Of particular note are her observations
-- on how to replicate the sheer brilliance of Annika Brilioth and the esoteric steps known as the Kriegstanz.
-- Adventurers say that reading it increases their evasion skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.EVASION)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.EVASION)
end

return itemObject
