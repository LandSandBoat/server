-----------------------------------
-- ID: 4936
-- Scroll of Huton: San
-- Teaches the ninjutsu Huton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(328)
end

itemObject.onItemUse = function(target)
    target:addSpell(328)
end

return itemObject
