-----------------------------------
-- ID: 6048
-- Noctohelix Schema
-- Teaches the black magic Noctohelix
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.NOCTOHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.NOCTOHELIX)
end

return itemObject
