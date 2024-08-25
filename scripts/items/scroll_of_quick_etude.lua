-----------------------------------
-- ID: 5035
-- Scroll of Quick Etude
-- Teaches the song Quick Etude
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.QUICK_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.QUICK_ETUDE)
end

return itemObject
