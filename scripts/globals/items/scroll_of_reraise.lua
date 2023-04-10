-----------------------------------
-- ID: 4743
-- Scroll of Reraise
-- Teaches the white magic Reraise
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(135)
end

itemObject.onItemUse = function(target)
    target:addSpell(135)
end

return itemObject
