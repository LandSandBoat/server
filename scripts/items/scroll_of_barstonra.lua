-----------------------------------
-- ID: 4677
-- Scroll of Barstonra
-- Teaches the white magic Barstonra
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARSTONRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARSTONRA)
end

return itemObject
