-----------------------------------
-- ID: 6061
-- Item: Adloquium Schema
-- Teaches the white magic Adloquium
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ADLOQUIUM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ADLOQUIUM)
end

return itemObject
