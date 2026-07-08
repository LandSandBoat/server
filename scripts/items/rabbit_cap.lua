-----------------------------------
-- ID: 26788
-- Item: Rabbit Cap
-- When used, you will obtain 1-2 random initial eggs
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { math.randomInt(xi.item.A_EGG, xi.item.Z_EGG), 1 } })

    if math.randomInt(1, 5) > 4 then
        npcUtil.giveItem(target, { { math.randomInt(xi.item.A_EGG, xi.item.Z_EGG), 1 } })
    end
end

return itemObject
