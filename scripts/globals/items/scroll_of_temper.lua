-----------------------------------
-- ID: 4705
-- Scroll of Temper
-- Teaches the white magic Temper
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(493)
end

itemObject.onItemUse = function(target)
    target:addSpell(493)
end

return itemObject
