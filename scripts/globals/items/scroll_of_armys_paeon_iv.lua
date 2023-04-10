-----------------------------------
-- ID: 4989
-- Scroll of Armys Paeton IV
-- Teaches the song Armys Paeton IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(381)
end

itemObject.onItemUse = function(target)
    target:addSpell(381)
end

return itemObject
