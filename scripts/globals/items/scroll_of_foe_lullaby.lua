-----------------------------------
-- ID: 5071
-- Scroll of Foe Lullaby
-- Teaches the song Foe Lullaby
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(463)
end

itemObject.onItemUse = function(target)
    target:addSpell(463)
end

return itemObject
