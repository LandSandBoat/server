-----------------------------------
-- ID: 4944
-- Scroll of Suiton: Ni
-- Teaches the ninjutsu Suiton: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(336)
end

itemObject.onItemUse = function(target)
    target:addSpell(336)
end

return itemObject
