-----------------------------------
-- ID: 4763
-- Scroll of Aero II
-- Teaches the black magic Aero II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(155)
end

itemObject.onItemUse = function(target)
    target:addSpell(155)
end

return itemObject
