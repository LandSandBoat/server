-----------------------------------
-- ID: 6055
-- Item: Aurorastorm Schema
-- Teaches the white magic Aurorastorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AURORASTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AURORASTORM)
end

return itemObject
