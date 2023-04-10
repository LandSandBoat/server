-----------------------------------
-- ID: 4970
-- Scroll of Gekka: Ichi
-- Teaches the ninjutsu Gekka: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(505)
end

itemObject.onItemUse = function(target)
    target:addSpell(505)
end

return itemObject
