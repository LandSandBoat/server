-----------------------------------
-- ID: 4937
-- Scroll of Doton: Ichi
-- Teaches the ninjutsu Doton: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(329)
end

itemObject.onItemUse = function(target)
    target:addSpell(329)
end

return itemObject
