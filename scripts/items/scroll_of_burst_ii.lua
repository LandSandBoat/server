-----------------------------------
-- ID: 4821
-- Scroll of Burst II
-- Teaches the black magic Burst II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BURST_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BURST_II)
end

return itemObject
