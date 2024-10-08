-----------------------------------
-- ID: 6391
-- Silt Pouch
-- Silt Pouch awards 50-99 Escha Silt on use.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local amount = math.random(50, 99)
    target:messageCombat(target, xi.item.SILT_POUCH, amount, xi.msg.combat.USE_OBTAIN_ESCHA_SILT)
    target:addCurrency('escha_silt', amount)
end

return itemObject
