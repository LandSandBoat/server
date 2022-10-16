-----------------------------------
-- ID: 4988
-- Scroll of Armys Paeton III
-- Teaches the song Armys Paeton III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(380)
end

itemObject.onItemUse = function(target)
    target:addSpell(380)
end

return itemObject
