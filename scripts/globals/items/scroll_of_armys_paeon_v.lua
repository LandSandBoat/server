-----------------------------------
-- ID: 4990
-- Scroll of Armys Paeton V
-- Teaches the song Armys Paeton V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(382)
end

itemObject.onItemUse = function(target)
    target:addSpell(382)
end

return itemObject
