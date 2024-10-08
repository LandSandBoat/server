-----------------------------------
-- ID: 5050
-- Scroll of Lightning Carol
-- Teaches the song Lightning Carol
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.LIGHTNING_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHTNING_CAROL)
end

return itemObject
