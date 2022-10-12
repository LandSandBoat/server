-----------------------------------
-- ID: 4945
-- Scroll of Suiton: San
-- Teaches the ninjutsu Suiton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(337)
end

itemObject.onItemUse = function(target)
    target:addSpell(337)
end

return itemObject
