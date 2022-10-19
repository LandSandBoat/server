-----------------------------------
-- ID: 5056
-- Scroll of Wind Carol II
-- Teaches the song Wind Carol II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(448)
end

itemObject.onItemUse = function(target)
    target:addSpell(448)
end

return itemObject
