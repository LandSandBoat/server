-----------------------------------
-- ID: 6045
-- Geohelix Schema
-- Teaches the black magic Geohelix
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GEOHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GEOHELIX)
end

return itemObject
