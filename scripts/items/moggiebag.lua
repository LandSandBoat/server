-----------------------------------
-- ID: 19246
-- Item: Moggiebag
-- Moogle's secret cache dispenses between 100 and 10,000 gil.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    local amount = math.random(100, 10000)
    npcUtil.giveCurrency(target, 'gil', amount)
end

return itemObject
