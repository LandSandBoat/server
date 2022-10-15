-----------------------------------
-- ID: 4962
-- Scroll of Tonko: Ichi
-- Teaches the ninjutsu Tonko: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(354)
end

itemObject.onItemUse = function(target)
    target:addSpell(354)
end

return itemObject
