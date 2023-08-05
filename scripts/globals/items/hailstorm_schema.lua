-----------------------------------
-- ID: 6052
-- Hailstorm Schema
-- Teaches the white magic Hailstorm
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HAILSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HAILSTORM)
end

return itemObject
