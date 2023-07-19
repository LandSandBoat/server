-----------------------------------
-- ID: 6053
-- Sandstorm Schema
-- Teaches the white magic Sandstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SANDSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SANDSTORM)
end

return itemObject
