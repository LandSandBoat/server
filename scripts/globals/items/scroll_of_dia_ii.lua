-----------------------------------
-- ID: 4632
-- Scroll of Dia II
-- Teaches the white magic Dia II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(24)
end

itemObject.onItemUse = function(target)
    target:addSpell(24)
end

return itemObject
