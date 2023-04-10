-----------------------------------
-- ID: 4757
-- Scroll of Blizzard
-- Teaches the black magic Blizzard
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(149)
end

itemObject.onItemUse = function(target)
    target:addSpell(149)
end

return itemObject
