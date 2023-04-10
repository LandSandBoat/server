-----------------------------------
-- ID: 5082
-- Scroll of Cura II
-- Teaches the white magic Cura II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(474)
end

itemObject.onItemUse = function(target)
    target:addSpell(474)
end

return itemObject
