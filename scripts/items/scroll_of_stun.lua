-----------------------------------
-- ID: 4860
-- Scroll of Stun
-- Teaches the black magic Stun
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.STUN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STUN)
end

return itemObject
