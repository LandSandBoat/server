-----------------------------------
-- ID: 5038
-- Scroll of Enchanting Etude
-- Teaches the song Enchanting Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(430)
end

itemObject.onItemUse = function(target)
    target:addSpell(430)
end

return itemObject
