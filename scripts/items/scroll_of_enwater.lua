-----------------------------------
-- ID: 4713
-- Scroll of Enwater
-- Teaches the white magic Enwater
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ENWATER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENWATER)
end

return itemObject
