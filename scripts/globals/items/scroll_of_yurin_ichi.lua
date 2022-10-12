-----------------------------------
-- ID: 4967
-- Scroll of Yurin: Ichi
-- Teaches the ninjutsu Yurin: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(508)
end

itemObject.onItemUse = function(target)
    target:addSpell(508)
end

return itemObject
