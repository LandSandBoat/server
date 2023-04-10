-----------------------------------
-- ID: 4929
-- Scroll of Katon: Ni
-- Teaches the ninjutsu Katon: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(321)
end

itemObject.onItemUse = function(target)
    target:addSpell(321)
end

return itemObject
