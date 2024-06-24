-----------------------------------
--  ID: 26720
--  Sheep Cap +1
--  When used, you will obtain one of eleven random items. They are:
--  Faerie Apple, Sunflower Seeds, Red Moko Grass, La Theine Cabbage, Boyahda Moss,
--  Pine Nuts, Beaugreens, Acorn, Dung, Batagreens, and Moko Grass
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    local giftList =
    {
        xi.item.FAERIE_APPLE,
        xi.item.SUNFLOWER_SEEDS,
        xi.item.CLUMP_OF_RED_MOKO_GRASS,
        xi.item.LA_THEINE_CABBAGE,
        xi.item.CLUMP_OF_BOYAHDA_MOSS,
        xi.item.HANDFUL_OF_PINE_NUTS,
        xi.item.CLUMP_OF_BEAUGREENS,
        xi.item.ACORN,
        xi.item.CLUMP_OF_BATAGREENS,
        xi.item.CLUMP_OF_MOKO_GRASS
    }

    local gift = math.random(1, 11)
    npcUtil.giveItem(target, { { giftList[gift], 1 } })
end

return itemObject
