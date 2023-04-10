-----------------------------------
-- ID: 5020
-- Scroll of Gold Capriccio
-- Teaches the song Gold Capriccio
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(412)
end

itemObject.onItemUse = function(target)
    target:addSpell(412)
end

return itemObject
