-----------------------------------
-- ID: 4726
-- Scroll of Enthunder II
-- Teaches the white magic Enthunder II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(316)
end

itemObject.onItemUse = function(target)
    target:addSpell(316)
end

return itemObject
