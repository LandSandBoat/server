-----------------------------------
-- ID: 4935
-- Scroll of Huton: Ni
-- Teaches the ninjutsu Huton: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(327)
end

itemObject.onItemUse = function(target)
    target:addSpell(327)
end

return itemObject
