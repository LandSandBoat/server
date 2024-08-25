-----------------------------------
-- ID: 4668
-- Scroll of Barfire
-- Teaches the white magic Barfire
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARFIRE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARFIRE)
end

return itemObject
