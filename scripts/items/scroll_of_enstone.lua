-----------------------------------
-- ID: 4711
-- Scroll of Enstone
-- Teaches the white magic Enstone
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ENSTONE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENSTONE)
end

return itemObject
