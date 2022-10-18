-----------------------------------
-- ID: 4943
-- Scroll of Suiton: Ichi
-- Teaches the ninjutsu Suiton: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(335)
end

itemObject.onItemUse = function(target)
    target:addSpell(335)
end

return itemObject
