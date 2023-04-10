-----------------------------------
-- ID: 5016
-- Scroll of Shining Fantasia
-- Teaches the song Shining Fantasia
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(408)
end

itemObject.onItemUse = function(target)
    target:addSpell(408)
end

return itemObject
