-----------------------------------
-- ID: 5033
-- Scroll of Dextrous Etude
-- Teaches the song Dextrous Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(425)
end

itemObject.onItemUse = function(target)
    target:addSpell(425)
end

return itemObject
