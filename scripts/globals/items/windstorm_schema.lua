-----------------------------------
-- ID: 6054
-- Windstorm Schema
-- Teaches the white magic Windstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WINDSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WINDSTORM)
end

return itemObject
