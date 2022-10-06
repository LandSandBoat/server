-----------------------------------
-- ID: 5018
-- Scroll of Puppets Operetta
-- Teaches the song Puppets Operetta
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(410)
end

itemObject.onItemUse = function(target)
    target:addSpell(410)
end

return itemObject
