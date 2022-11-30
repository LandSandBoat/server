-----------------------------------
-- ID: 4971
-- Scroll of Yain: Ichi
-- Teaches the ninjutsu Yain: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(506)
end

itemObject.onItemUse = function(target)
    target:addSpell(506)
end

return itemObject
