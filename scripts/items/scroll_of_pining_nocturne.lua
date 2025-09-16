-----------------------------------
-- ID: 5080
-- Scroll of Pining Nocturne
-- Teaches the song Pining Nocturne
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.PINING_NOCTURNE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PINING_NOCTURNE)
end

return itemObject
