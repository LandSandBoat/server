-----------------------------------
-- ID: 4987
-- Scroll of Armys Paeton II
-- Teaches the song Armys Paeton II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(379)
end

itemObject.onItemUse = function(target)
    target:addSpell(379)
end

return itemObject
