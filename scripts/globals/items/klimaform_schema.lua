-----------------------------------
-- ID: 6058
-- Klimaform Schema
-- Teaches the black magic Klimaform
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KLIMAFORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KLIMAFORM)
end

return itemObject
