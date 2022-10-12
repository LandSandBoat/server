-----------------------------------
-- ID: 4955
-- Scroll of Kurayami: Ichi
-- Teaches the ninjutsu Kurayami: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(347)
end

itemObject.onItemUse = function(target)
    target:addSpell(347)
end

return itemObject
