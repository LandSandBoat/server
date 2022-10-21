-----------------------------------
-- ID: 4774
-- Scroll of Thunder III
-- Teaches the black magic Thunder III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(166)
end

itemObject.onItemUse = function(target)
    target:addSpell(166)
end

return itemObject
