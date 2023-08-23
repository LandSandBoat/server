-----------------------------------
-- ID: 6050
-- Rainstorm Schema
-- Teaches the white magic Rainstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RAINSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RAINSTORM)
end

return itemObject
