-----------------------------------
-- ID: 6051
-- Thunderstorm Schema
-- Teaches the white magic Thunderstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDERSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDERSTORM)
end

return itemObject
