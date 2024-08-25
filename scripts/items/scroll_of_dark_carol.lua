-----------------------------------
-- ID: 5053
-- Scroll of Dark Carol
-- Teaches the song Dark Carol
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DARK_CAROL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DARK_CAROL)
end

return itemObject
