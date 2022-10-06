-----------------------------------
-- ID: 4947
-- Scroll of Utsusemi: Ni
-- Teaches the ninjutsu Utsusemi: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(339)
end

itemObject.onItemUse = function(target)
    target:addSpell(339)
end

return itemObject
