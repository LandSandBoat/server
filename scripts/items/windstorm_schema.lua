-----------------------------------
-- ID: 6054
-- Windstorm Schema
-- Teaches the white magic Windstorm
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WINDSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WINDSTORM)
end

return itemObject
