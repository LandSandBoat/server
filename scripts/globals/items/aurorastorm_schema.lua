-----------------------------------
-- ID: 6055
-- Item: Aurorastorm Schema
-- Teaches the white magic Aurorastorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(119)
end

itemObject.onItemUse = function(target)
    target:addSpell(119)
end

return itemObject
