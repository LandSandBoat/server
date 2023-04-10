-----------------------------------
-- ID: 4991
-- Scroll of Armys Paeton VI
-- Teaches the song Armys Paeton VI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(383)
end

itemObject.onItemUse = function(target)
    target:addSpell(383)
end

return itemObject
