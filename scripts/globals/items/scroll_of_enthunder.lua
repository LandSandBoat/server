-----------------------------------
-- ID: 4712
-- Scroll of Enthunder
-- Teaches the white magic Enthunder
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(104)
end

itemObject.onItemUse = function(target)
    target:addSpell(104)
end

return itemObject
