-----------------------------------
-- ID: 4928
-- Scroll of Katon: Ichi
-- Teaches the ninjutsu Katon: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(320)
end

itemObject.onItemUse = function(target)
    target:addSpell(320)
end

return itemObject
