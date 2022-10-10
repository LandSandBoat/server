-----------------------------------
-- ID: 5041
-- Scroll of Vital Etude
-- Teaches the song Vital Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(433)
end

itemObject.onItemUse = function(target)
    target:addSpell(433)
end

return itemObject
