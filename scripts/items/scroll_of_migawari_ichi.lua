-----------------------------------
-- ID: 4969
-- Scroll of Migawari: Ichi
-- Teaches the ninjutsu Migawari: Ichi
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.MIGAWARI_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.MIGAWARI_ICHI)
end

return itemObject
