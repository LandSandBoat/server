-----------------------------------
-- ID: 4953
-- Scroll of Hojo: Ni
-- Teaches the ninjutsu Hojo: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(345)
end

itemObject.onItemUse = function(target)
    target:addSpell(345)
end

return itemObject
