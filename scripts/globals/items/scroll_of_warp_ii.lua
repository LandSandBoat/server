-----------------------------------
-- ID: 4870
-- Scroll of Warp II
-- Teaches the black magic Warp II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(262)
end

itemObject.onItemUse = function(target)
    target:addSpell(262)
end

return itemObject
