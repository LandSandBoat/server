-----------------------------------
-- Celebratory Chest stock before Popper II was added in May 2022.
-- Source: https://wiki.ffo.jp/html/38541.html
-----------------------------------
require('modules/module_utils')
require('scripts/globals/shop')
-----------------------------------
local m = Module:new('celebratory_chest_stock', xi.pre(xi.expansion.TVR))

m:addOverride('xi.shop.celebratory', function(player)
    local stock =
    {
        { xi.item.CRACKER,                 30 },
        { xi.item.TWINKLE_SHOWER,          30 },
        { xi.item.POPSTAR,                 60 },
        { xi.item.BRILLIANT_SNOW,          60 },
        { xi.item.OUKA_RANMAN,             30 },
        { xi.item.LITTLE_COMET,            30 },
        { xi.item.POPPER,                 650 },
        { xi.item.WEDDING_BELL,          1000 },
        { xi.item.SERENE_SERINETTE,      6000 },
        { xi.item.JOYOUS_SERINETTE,      6000 },
        { xi.item.BOTTLE_OF_GRAPE_JUICE, 1116 },
        { xi.item.INFERNO_CRYSTAL,       3000 },
        { xi.item.CYCLONE_CRYSTAL,       3000 },
        { xi.item.TERRA_CRYSTAL,         3000 },
    }
    xi.shop.general(player, stock)
end)
