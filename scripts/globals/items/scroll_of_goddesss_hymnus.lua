-----------------------------------
-- ID: 5072
-- Scroll of Goddess's Hymnus
-- Teaches the song Goddess's Hymnus
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(464)
end

itemObject.onItemUse = function(target)
    target:addSpell(464)
end

return itemObject
