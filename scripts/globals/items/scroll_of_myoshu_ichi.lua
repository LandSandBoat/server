-----------------------------------
-- ID: 4966
-- Scroll of Myoshu: Ichi
-- Teaches the ninjutsu Myoshu: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(507)
end

itemObject.onItemUse = function(target)
    target:addSpell(507)
end

return itemObject
