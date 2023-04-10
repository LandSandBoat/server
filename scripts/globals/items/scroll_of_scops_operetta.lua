-----------------------------------
-- ID: 5017
-- Scroll of Scops Operetta
-- Teaches the song Scops Operetta
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(409)
end

itemObject.onItemUse = function(target)
    target:addSpell(409)
end

return itemObject
