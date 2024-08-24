-----------------------------------
-- ID: 4694
-- Scroll of Barsleepra
-- Teaches the white magic Barsleepra
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARSLEEPRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARSLEEPRA)
end

return itemObject
