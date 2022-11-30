-----------------------------------
-- ID: 4892
-- Scroll of Aeroja
-- Teaches the black magic Aeroja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(498)
end

itemObject.onItemUse = function(target)
    target:addSpell(498)
end

return itemObject
