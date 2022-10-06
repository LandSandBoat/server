-----------------------------------
-- ID: 5013
-- Scroll of Fowl Aubade
-- Teaches the song Fowl Aubade
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(405)
end

itemObject.onItemUse = function(target)
    target:addSpell(405)
end

return itemObject
