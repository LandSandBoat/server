-----------------------------------
-- ID: 4941
-- Scroll of Raiton: Ni
-- Teaches the ninjutsu Raiton: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(333)
end

itemObject.onItemUse = function(target)
    target:addSpell(333)
end

return itemObject
