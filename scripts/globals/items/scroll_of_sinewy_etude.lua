-----------------------------------
-- ID: 5032
-- Scroll of Sinewy Etude
-- Teaches the song Sinewy Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(424)
end

itemObject.onItemUse = function(target)
    target:addSpell(424)
end

return itemObject
