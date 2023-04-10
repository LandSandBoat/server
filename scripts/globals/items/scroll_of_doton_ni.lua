-----------------------------------
-- ID: 4938
-- Scroll of Doton: ni
-- Teaches the ninjutsu Doton: ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(330)
end

itemObject.onItemUse = function(target)
    target:addSpell(330)
end

return itemObject
