-----------------------------------
-- ID: 4952
-- Scroll of Hojo: Ichi
-- Teaches the ninjutsu Hojo: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(344)
end

itemObject.onItemUse = function(target)
    target:addSpell(344)
end

return itemObject
