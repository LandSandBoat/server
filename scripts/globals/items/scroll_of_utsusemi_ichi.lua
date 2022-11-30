-----------------------------------
-- ID: 4946
-- Scroll of Utsusemi: Ichi
-- Teaches the ninjutsu Utsusemi: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(338)
end

itemObject.onItemUse = function(target)
    target:addSpell(338)
end

return itemObject
