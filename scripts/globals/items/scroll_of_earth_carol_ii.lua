-----------------------------------
-- ID: 5057
-- Scroll of Earth Carol II
-- Teaches the song Earth Carol II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(449)
end

itemObject.onItemUse = function(target)
    target:addSpell(449)
end

return itemObject
