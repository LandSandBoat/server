-----------------------------------
-- ID: 6049
-- Firestorm Schema
-- Teaches the white magic Firestorm
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRESTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRESTORM)
end

return itemObject
