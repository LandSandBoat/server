-----------------------------------
-- ID: 5070
-- Scroll of Magic Finale
-- Teaches the song Magic Finale
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(462)
end

itemObject.onItemUse = function(target)
    target:addSpell(462)
end

return itemObject
