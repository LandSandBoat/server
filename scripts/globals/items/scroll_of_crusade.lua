-----------------------------------
-- ID: 5103
-- Scroll of Crusade
-- Teaches the white magic Crusade
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(476)
end

itemObject.onItemUse = function(target)
    target:addSpell(476)
end

return itemObject
