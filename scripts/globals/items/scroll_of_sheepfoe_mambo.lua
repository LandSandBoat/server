-----------------------------------
-- ID: 5011
-- Scroll of Sheepfoe Mambo
-- Teaches the song Sheepfoe Mambo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(403)
end

itemObject.onItemUse = function(target)
    target:addSpell(403)
end

return itemObject
