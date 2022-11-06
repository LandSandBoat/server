-----------------------------------
-- ID: 5034
-- Scroll of Vivacious Etude
-- Teaches the song Vivacious Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(426)
end

itemObject.onItemUse = function(target)
    target:addSpell(426)
end

return itemObject
