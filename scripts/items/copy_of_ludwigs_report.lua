-----------------------------------
-- ID: 6153
-- Item: Ludwig's Report
-- A report made by Ludwig Eichberg regarding the Battle of Grauberg.
-- It details the constant changes in the position of the front line and the withdrawal of Republic troops.
-- Adventurers note that reading it increases one's scythe skill.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.skillBookCheck(target, xi.skill.SCYTHE)
end

itemObject.onItemUse = function(target)
    xi.itemUtils.skillBookUse(target, xi.skill.SCYTHE)
end

return itemObject
