-----------------------------------
-- ID: 4636
-- Scroll of Banish
-- Teaches the white magic Banish
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(28)
end

itemObject.onItemUse = function(target)
    target:addSpell(28)
end

return itemObject
