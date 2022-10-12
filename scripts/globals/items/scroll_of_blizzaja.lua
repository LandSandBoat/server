
-----------------------------------
-- ID: 4891
-- Scroll of blizzaja
-- Teaches the black magic blizzaja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(497)
end

itemObject.onItemUse = function(target)
    target:addSpell(497)
end

return itemObject
