-----------------------------------
-- ID: 4787
-- Scroll of Blizzaga
-- Teaches the black magic Blizzaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(179)
end

itemObject.onItemUse = function(target)
    target:addSpell(179)
end

return itemObject
