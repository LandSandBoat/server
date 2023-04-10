-----------------------------------
-- ID: 5096
-- Scroll of Boost-VIT
-- Teaches the white magic Boost-VIT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(481)
end

itemObject.onItemUse = function(target)
    target:addSpell(481)
end

return itemObject
