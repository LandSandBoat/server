
-----------------------------------
-- ID: 4776
-- Scroll of thunder v
-- Teaches the black magic thunder v
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(168)
end

itemObject.onItemUse = function(target)
    target:addSpell(168)
end

return itemObject
