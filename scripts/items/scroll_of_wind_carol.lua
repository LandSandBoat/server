-----------------------------------
-- ID: 5048
-- Scroll of Wind Carol
-- Teaches the song Wind Carol
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.WIND_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WIND_CAROL)
end

return itemObject
