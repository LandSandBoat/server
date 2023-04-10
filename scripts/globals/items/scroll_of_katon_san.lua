-----------------------------------
-- ID: 4930
-- Scroll of Katon: San
-- Teaches the ninjutsu Katon: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(322)
end

itemObject.onItemUse = function(target)
    target:addSpell(322)
end

return itemObject
