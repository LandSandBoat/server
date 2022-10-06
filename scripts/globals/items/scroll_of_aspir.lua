-----------------------------------
-- ID: 4855
-- Scroll of Aspir
-- Teaches the black magic Aspir
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(247)
end

itemObject.onItemUse = function(target)
    target:addSpell(247)
end

return itemObject
