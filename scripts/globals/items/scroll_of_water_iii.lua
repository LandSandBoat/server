-----------------------------------
-- ID: 4779
-- Scroll of Water III
-- Teaches the black magic Water III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(171)
end

itemObject.onItemUse = function(target)
    target:addSpell(171)
end

return itemObject
