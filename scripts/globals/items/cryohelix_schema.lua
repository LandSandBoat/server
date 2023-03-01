-----------------------------------
-- ID: 6044
-- Cryohelix Schema
-- Teaches the black magic Cryohelix
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CRYOHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CRYOHELIX)
end

return itemObject
