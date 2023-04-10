-----------------------------------
-- ID: 4798
-- Scroll of Stonega II
-- Teaches the black magic Stonega II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(190)
end

itemObject.onItemUse = function(target)
    target:addSpell(190)
end

return itemObject
