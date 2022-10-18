-----------------------------------
-- ID: 4734
-- Scroll of Protectra II
-- Teaches the white magic Protectra II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(126)
end

itemObject.onItemUse = function(target)
    target:addSpell(126)
end

return itemObject
