-----------------------------------
-- ID: 4628
-- Scroll of Cursna
-- Teaches the white magic Cursna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(20)
end

itemObject.onItemUse = function(target)
    target:addSpell(20)
end

return itemObject
