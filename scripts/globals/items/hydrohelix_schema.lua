-----------------------------------
-- ID: 6042
-- Hydrohelix Schema
-- Teaches the black magic Hydrohelix
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HYDROHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HYDROHELIX)
end

return itemObject
