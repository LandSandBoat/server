-----------------------------------
-- ID: 4934
-- Scroll of Huton: Ichi
-- Teaches the ninjutsu Huton: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(326)
end

itemObject.onItemUse = function(target)
    target:addSpell(326)
end

return itemObject
