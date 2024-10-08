-----------------------------------
-- ID: 4809
-- Scroll of Waterga III
-- Teaches the black magic Waterga III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WATERGA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERGA_III)
end

return itemObject
