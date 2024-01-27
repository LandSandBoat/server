-----------------------------------
-- ID: 6158
-- Item: K-P's Memoirs
-- Memoirs penned by Kayeel-Payeel.
-- They describe in particular detail the time he received Claustrum from the Warlock Warlord Robel-Akbel.
-- Adventurers note that reading them increases one's staff skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.STAFF)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.STAFF)
end

return itemObject
