-----------------------------------
-- ID: 4627
-- Scroll of Viruna
-- Teaches the white magic Viruna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(19)
end

itemObject.onItemUse = function(target)
    target:addSpell(19)
end

return itemObject
