-----------------------------------
-- ID: 4733
-- Scroll of Protectra
-- Teaches the white magic Protectra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(125)
end

itemObject.onItemUse = function(target)
    target:addSpell(125)
end

return itemObject
