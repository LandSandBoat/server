-----------------------------------
-- ID: 4646
-- Scroll of Banishga
-- Teaches the white magic Banishga
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BANISHGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BANISHGA)
end

return itemObject
