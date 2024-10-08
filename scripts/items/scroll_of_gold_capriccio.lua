-----------------------------------
-- ID: 5020
-- Scroll of Gold Capriccio
-- Teaches the song Gold Capriccio
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.GOLD_CAPRICCIO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GOLD_CAPRICCIO)
end

return itemObject
