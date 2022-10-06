-----------------------------------
-- ID: 5079
-- Scroll of Foe Lullaby II
-- Teaches the song Foe Lullaby II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(471)
end

itemObject.onItemUse = function(target)
    target:addSpell(471)
end

return itemObject
