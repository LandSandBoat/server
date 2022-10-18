-----------------------------------
-- ID: 4755
-- Scroll of Fire IV
-- Teaches the black magic Fire IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(147)
end

itemObject.onItemUse = function(target)
    target:addSpell(147)
end

return itemObject
