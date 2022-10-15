-----------------------------------
-- ID: 5012
-- Scroll of Dragonfoe Mambo
-- Teaches the song Dragonfoe Mambo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(404)
end

itemObject.onItemUse = function(target)
    target:addSpell(404)
end

return itemObject
