-----------------------------------
-- ID: 5045
-- Scroll of Bewitching Etude
-- Teaches the song Bewitching Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(437)
end

itemObject.onItemUse = function(target)
    target:addSpell(437)
end

return itemObject
