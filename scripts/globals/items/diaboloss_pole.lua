-----------------------------------
-- ID: 17599
-- Diabolos's Pole
-----------------------------------
local itemObject = {}

itemObject.onItemEquip = function(player, item)
    player:setCharVar("Diaboloss_Pole", 1)
end

itemObject.onItemUnequip = function(player, item)
    player:setCharVar("Diaboloss_Pole", 0)
end

return itemObject
