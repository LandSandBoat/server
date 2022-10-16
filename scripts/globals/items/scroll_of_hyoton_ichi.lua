-----------------------------------
-- ID: 4931
-- Scroll of Hyoton: Ichi
-- Teaches the ninjutsu Hyoton: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(323)
end

itemObject.onItemUse = function(target)
    target:addSpell(323)
end

return itemObject
