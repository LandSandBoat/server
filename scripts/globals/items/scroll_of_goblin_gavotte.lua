-----------------------------------
-- ID: 5023
-- Scroll of Goblin Gavotte
-- Teaches the song Goblin Gavotte
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(415)
end

itemObject.onItemUse = function(target)
    target:addSpell(415)
end

return itemObject
