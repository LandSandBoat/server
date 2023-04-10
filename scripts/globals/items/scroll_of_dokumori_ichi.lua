-----------------------------------
-- ID: 4958
-- Scroll of Dokumori: Ichi
-- Teaches the ninjutsu Dokumori: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(350)
end

itemObject.onItemUse = function(target)
    target:addSpell(350)
end

return itemObject
