-----------------------------------
-- ID: 4914
-- Scroll of Frazzle
-- Teaches the black magic Frazzle
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(843)
end

itemObject.onItemUse = function(target)
    target:addSpell(843)
end

return itemObject
