-----------------------------------
-- ID: 4770
-- Scroll of Stone IV
-- Teaches the black magic Stone IV
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.STONE_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONE_IV)
end

return itemObject
