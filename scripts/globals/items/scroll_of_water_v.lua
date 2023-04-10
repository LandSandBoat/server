-----------------------------------
-- ID: 4781
-- Scroll of Water V
-- Teaches the black magic Water V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(173)
end

itemObject.onItemUse = function(target)
    target:addSpell(173)
end

return itemObject
