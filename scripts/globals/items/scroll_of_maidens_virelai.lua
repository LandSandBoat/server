-----------------------------------
-- ID: 5074
-- Scroll of Maiden's Virelai
-- Teaches the song Maiden's Virelai
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(466)
end

itemObject.onItemUse = function(target)
    target:addSpell(466)
end

return itemObject
