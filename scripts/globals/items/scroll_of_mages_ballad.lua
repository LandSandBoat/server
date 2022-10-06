-----------------------------------
-- ID: 4994
-- Scroll of Mages Ballad
-- Teaches the song Mages Ballad
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(386)
end

itemObject.onItemUse = function(target)
    target:addSpell(386)
end

return itemObject
