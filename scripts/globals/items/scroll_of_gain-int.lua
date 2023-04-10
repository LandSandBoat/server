-----------------------------------
-- ID: 5091
-- Scroll of Gain-INT
-- Teaches the white magic Gain-INT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(490)
end

itemObject.onItemUse = function(target)
    target:addSpell(490)
end

return itemObject
