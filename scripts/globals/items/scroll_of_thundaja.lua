-----------------------------------
-- ID: 4894
-- Scroll of Thundaj
-- Teaches the black magic Thundaj
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(500)
end

itemObject.onItemUse = function(target)
    target:addSpell(500)
end

return itemObject
