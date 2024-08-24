-----------------------------------
-- ID: 4632
-- Scroll of Dia II
-- Teaches the white magic Dia II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DIA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DIA_II)
end

return itemObject
