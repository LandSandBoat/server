-----------------------------------
-- ID: 6392
-- Bead Pouch
-- Bead Pouch awards 5-10 beads on use.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local amount = math.random(5, 10)
    target:messageCombat(target, xi.item.BEAD_POUCH, amount, xi.msg.combat.USE_OBTAIN_ESCHA_BEAD)
    target:addCurrency('escha_beads', amount)
end

return itemObject
