-----------------------------------
-- ID: 5033
-- Scroll of Dextrous Etude
-- Teaches the song Dextrous Etude
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DEXTROUS_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DEXTROUS_ETUDE)
end

return itemObject
