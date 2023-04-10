-----------------------------------
-- ID: 4969
-- Scroll of Migawari: Ichi
-- Teaches the ninjutsu Migawari: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(510)
end

itemObject.onItemUse = function(target)
    target:addSpell(510)
end

return itemObject
