-----------------------------------
-- ID: 4932
-- Scroll of Hyoton: San
-- Teaches the ninjutsu Hyoton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(325)
end

itemObject.onItemUse = function(target)
    target:addSpell(325)
end

return itemObject
