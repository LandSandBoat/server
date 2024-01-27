-----------------------------------
-- ID: 6159
-- Item: Perih's Primer
-- A guidebook Perih Vashai jotted down for the edification of new recruits.
-- It discusses everything from the various ways of holding a bow to methods of judging distance.
-- Adventurers note that reading it increases one's archery skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.ARCHERY)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.ARCHERY)
end

return itemObject
