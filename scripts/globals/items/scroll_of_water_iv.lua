-----------------------------------
-- ID: 4780
-- Scroll of Water IV
-- Teaches the black magic Water IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(172)
end

itemObject.onItemUse = function(target)
    target:addSpell(172)
end

return itemObject
