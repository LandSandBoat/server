-----------------------------------
-- ID: 4770
-- Scroll of Stone IV
-- Teaches the black magic Stone IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(162)
end

itemObject.onItemUse = function(target)
    target:addSpell(162)
end

return itemObject
