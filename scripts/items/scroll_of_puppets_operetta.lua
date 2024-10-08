-----------------------------------
-- ID: 5018
-- Scroll of Puppets Operetta
-- Teaches the song Puppets Operetta
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.PUPPETS_OPERETTA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PUPPETS_OPERETTA)
end

return itemObject
