-----------------------------------
-- ID: 4872
-- Scroll of Tractor
-- Teaches the black magic Tractor
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(264)
end

itemObject.onItemUse = function(target)
    target:addSpell(264)
end

return itemObject
