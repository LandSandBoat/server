-----------------------------------
-- ID: 4721
-- Scroll of Repose
-- Teaches the white magic Repose
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(98)
end

itemObject.onItemUse = function(target)
    target:addSpell(98)
end

return itemObject
