-----------------------------------
-- ID: 4724
-- Scroll of Enaero II
-- Teaches the white magic Enaero II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(314)
end

itemObject.onItemUse = function(target)
    target:addSpell(314)
end

return itemObject
