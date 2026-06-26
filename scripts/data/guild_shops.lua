-----------------------------------
-- Guild shop definitions
-----------------------------------
xi = xi or {}
xi.data = xi.data or {}

---@class GuildShopItem
---@field id          xi.item
---@field initial     integer   -- stock on server restart
---@field maxStock    integer   -- hard ceiling the shop can hold
---@field targetStock integer   -- stock each open settles to (restock fills up to it, overstock trims down)
---@field buyMax      integer   -- buy price when the shelf is empty (top of the buy curve)
---@field restockRate integer   -- items restocked per day, up to targetStock
---@field hidden?     boolean   -- sell-list row hidden from the client
---@field noSell?     boolean   -- item can be bought but not sold back to the shop
---@field sellPrice?  integer   -- flat sell-back price override; defaults to the stock-scaled curve
---@field priceFloor? integer   -- buy-curve floor override; defaults to 3/4 of maxStock

---@class GuildShop
---@field hours      integer[]          -- { openHour, closeHour }
---@field stock      GuildShopItem[]

---@type table<string, GuildShop>
xi.data.guildShops =
{
    ['Amulya'] =
    {
        hours = { 8, 23 },
        stock =
        {
            { id = xi.item.CHUNK_OF_TIN_ORE,         initial = 180, maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 40 },
            { id = xi.item.CHUNK_OF_IRON_ORE,        initial = 180, maxStock = 240, targetStock = 180, buyMax = 4500,   restockRate = 30 },
            { id = xi.item.CHUNK_OF_MYTHRIL_ORE,     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 10000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHUNK_OF_DARKSTEEL_ORE,   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 28500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_INGOT,             initial = 36,  maxStock = 240, targetStock = 180, buyMax = 380,    restockRate = 12 },
            { id = xi.item.IRON_INGOT,               initial = 36,  maxStock = 240, targetStock = 180, buyMax = 18000,  restockRate = 12 },
            { id = xi.item.STEEL_INGOT,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 26250,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_INGOT,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 50000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_INGOT,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 142500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SHEET,             initial = 36,  maxStock = 240, targetStock = 180, buyMax = 460,    restockRate = 12 },
            { id = xi.item.IRON_SHEET,               initial = 36,  maxStock = 240, targetStock = 180, buyMax = 27000,  restockRate = 12 },
            { id = xi.item.STEEL_SHEET,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 42000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SHEET,            initial = 0,   maxStock = 240, targetStock = 180, buyMax = 60000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_SHEET,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 171000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_BRONZE_SCALES, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 540,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_IRON_SCALES,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_STEEL_SCALES,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 49500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_CHAIN,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CHAIN,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 199500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_KNUCKLES,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1220,   restockRate = 0 },
            { id = xi.item.METAL_KNUCKLES,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 26190,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_KNUCKLES,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 103320, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_KNUCKLES,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 233700, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAGHNAKHS,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 43200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PATAS,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 228800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_KNIFE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 820,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KNIFE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12125,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_KNIFE,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 72800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_KNIFE,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 288600, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KUKRI,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31050,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_KUKRI,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 99360,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCIMITAR,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22625,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TULWAR,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 194000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FALCHION,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 340000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_FALCHION,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 555000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BILBO,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 17475,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TUCK,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 64380,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DEGEN,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51120,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCHLAEGER,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 559000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_AXE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1580,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BATTLEAXE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 61335,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_AXE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 243000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TABAR,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 330000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BUTTERFLY_AXE,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3360,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREATAXE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HEAVY_AXE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 206080, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_HAMMER,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1700,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WARHAMMER,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 32790,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAUL,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 79800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ARQUEBUS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 260200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_LEGGINGS,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 640,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEGGINGS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 78720,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PLATE_LEGGINGS,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 118800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_CAP,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 840,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PADDED_CAP,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 102000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SUBLIGAR,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1040,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_SUBLIGAR,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 126720, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUISSES,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 189000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_MITTENS,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 700,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_MITTENS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 86400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GAUNTLETS,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 129600, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_HARNESS,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1280,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PADDED_ARMOR,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 157440, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BREASTPLATE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 245700, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GORGET,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 91800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASPIS,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4725,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TARGE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 61200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCUTUM,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 273600, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CROSSBOW_BOLT,            initial = 0,   maxStock = 240, targetStock = 180, buyMax = 30,     restockRate = 0 },
            { id = xi.item.MYTHRIL_BOLT,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 120,    restockRate = 0 },
            { id = xi.item.TATHLUM,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1610,   restockRate = 0 },
            { id = xi.item.BRONZE_BED,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 38925,  restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Beugungel'] =
    {
        hours = { 5, 22 },
        stock =
        {
            { id = xi.item.SPOOL_OF_BUNDLING_TWINE, initial = 180, maxStock = 240, targetStock = 180, buyMax = 500,  restockRate = 60 },
            { id = xi.item.HATCHET,                 initial = 180, maxStock = 200, targetStock = 180, buyMax = 2500, restockRate = 60, priceFloor = 180 },
            { id = xi.item.ARROWWOOD_LOG,           initial = 180, maxStock = 200, targetStock = 180, buyMax = 100,  restockRate = 60, priceFloor = 180 },
            { id = xi.item.ASH_LOG,                 initial = 180, maxStock = 200, targetStock = 180, buyMax = 480,  restockRate = 60, priceFloor = 180 },
            { id = xi.item.YEW_LOG,                 initial = 150, maxStock = 200, targetStock = 150, buyMax = 2200, restockRate = 50 },
            { id = xi.item.WILLOW_LOG,              initial = 150, maxStock = 200, targetStock = 150, buyMax = 800,  restockRate = 50 },
            { id = xi.item.WALNUT_LOG,              initial = 180, maxStock = 240, targetStock = 180, buyMax = 4270, restockRate = 20 },
        },
    },
    ['Blabbivix'] =
    {
        hours = { 11, 22 },
        stock =
        {
            { id = xi.item.RED_CHIP,    initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.BLUE_CHIP,   initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.YELLOW_CHIP, initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.GREEN_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.CLEAR_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.PURPLE_CHIP, initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.WHITE_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.BLACK_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
        },
    },
    ['Chiyo'] =
    {
        hours = { 9, 23 },
        stock =
        {
            { id = xi.item.SCROLL_OF_ABSORB_STR,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_DEX,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_VIT,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_AGI,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_INT,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_MND,    initial = 30, maxStock = 60, targetStock = 45, buyMax = 105000, restockRate = 5 },
            { id = xi.item.SCROLL_OF_ABSORB_CHR,    initial = 30, maxStock = 60, targetStock = 45, buyMax = 105000, restockRate = 5 },
            { id = xi.item.SCROLL_OF_KATON_ICHI,    initial = 30, maxStock = 60, targetStock = 45, buyMax = 11655,  restockRate = 5 },
            { id = xi.item.SCROLL_OF_HYOTON_ICHI,   initial = 30, maxStock = 60, targetStock = 45, buyMax = 11655,  restockRate = 5 },
            { id = xi.item.SCROLL_OF_HUTON_ICHI,    initial = 30, maxStock = 60, targetStock = 45, buyMax = 11655,  restockRate = 5 },
            { id = xi.item.SCROLL_OF_DOTON_ICHI,    initial = 30, maxStock = 60, targetStock = 45, buyMax = 11655,  restockRate = 5 },
            { id = xi.item.SCROLL_OF_RAITON_ICHI,   initial = 30, maxStock = 60, targetStock = 45, buyMax = 11655,  restockRate = 5 },
            { id = xi.item.SCROLL_OF_SUITON_ICHI,   initial = 30, maxStock = 60, targetStock = 45, buyMax = 11655,  restockRate = 5 },
            { id = xi.item.SCROLL_OF_UTSUSEMI_ICHI, initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14240,  restockRate = 0 },
            { id = xi.item.SCROLL_OF_JUBAKU_ICHI,   initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_HOJO_ICHI,     initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_KURAYAMI_ICHI, initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_DOKUMORI_ICHI, initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_TONKO_ICHI,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_MONOMI_ICHI,   initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14240,  restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Gaudylox'] =
    {
        hours = { 11, 22 },
        stock =
        {
            { id = xi.item.RED_CHIP,    initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.BLUE_CHIP,   initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.YELLOW_CHIP, initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.GREEN_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.CLEAR_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.PURPLE_CHIP, initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.WHITE_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.BLACK_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
        },
    },
    ['Ilita'] =
    {
        hours = { 12, 20 },
        stock =
        {
            { id = xi.item.NEW_LINKSHELL,   initial = 75,  maxStock = 100, targetStock = 75,  buyMax = 6000, restockRate = 0, priceFloor = 0, sellPrice = 2250 }, -- Not a typo, they do not restock on retail.
            { id = xi.item.PENDANT_COMPASS, initial = 150, maxStock = 200, targetStock = 150, buyMax = 375,  restockRate = 0, priceFloor = 0, noSell = true },
        },
    },
    ['Kamilah'] =
    {
        hours = { 8, 23 },
        stock =
        {
            { id = xi.item.CHUNK_OF_TIN_ORE,         initial = 110, maxStock = 240, targetStock = 110, buyMax = 200,    restockRate = 20 },
            { id = xi.item.CHUNK_OF_IRON_ORE,        initial = 110, maxStock = 240, targetStock = 110, buyMax = 4500,   restockRate = 10 },
            { id = xi.item.BRONZE_INGOT,             initial = 0,   maxStock = 120, targetStock = 100, buyMax = 380,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_INGOT,               initial = 0,   maxStock = 120, targetStock = 100, buyMax = 18000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_INGOT,              initial = 90,  maxStock = 120, targetStock = 100, buyMax = 26250,  restockRate = 10 },
            { id = xi.item.BRONZE_SHEET,             initial = 36,  maxStock = 120, targetStock = 100, buyMax = 460,    restockRate = 2 },
            { id = xi.item.IRON_SHEET,               initial = 0,   maxStock = 120, targetStock = 100, buyMax = 27000,  restockRate = 0 },
            { id = xi.item.HANDFUL_OF_BRONZE_SCALES, initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 540,    restockRate = 0 },
            { id = xi.item.HANDFUL_OF_IRON_SCALES,   initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 31500,  restockRate = 0 },
            { id = xi.item.IRON_CHAIN,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHAINMAIL,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 79200,  restockRate = 0 },
            { id = xi.item.SCALE_MAIL,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 11150,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PADDED_ARMOR,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 157440, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREAVES,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 38700,  restockRate = 0 },
            { id = xi.item.SCALE_GREAVES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5420,   restockRate = 0 },
            { id = xi.item.LEGGINGS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 78720,  restockRate = 0 },
            { id = xi.item.CHAIN_MITTENS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42300,  restockRate = 0 },
            { id = xi.item.SCALE_FINGER_GAUNTLETS,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5950,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_MITTENS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 86400,  restockRate = 0 },
        },
    },
    ['Khel_Pahlhama'] =
    {
        hours = { 12, 20 },
        stock =
        {
            { id = xi.item.NEW_LINKSHELL,   initial = 75,  maxStock = 100, targetStock = 75,  buyMax = 6000, restockRate = 0, priceFloor = 0, sellPrice = 2250 }, -- Not a typo, they do not restock on retail.
            { id = xi.item.PENDANT_COMPASS, initial = 150, maxStock = 200, targetStock = 150, buyMax = 375,  restockRate = 0, priceFloor = 0, noSell = true },
        },
    },
    ['Kopopo'] =
    {
        hours = { 5, 20 },
        stock =
        {
            { id = xi.item.BAG_OF_HORO_FLOUR,            initial = 0,   maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAG_OF_RYE_FLOUR,             initial = 144, maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 12 },
            { id = xi.item.BAG_OF_SAN_DORIAN_FLOUR,      initial = 144, maxStock = 240, targetStock = 180, buyMax = 300,   restockRate = 12 },
            { id = xi.item.BUNCH_OF_KAZHAM_PEPPERS,      initial = 144, maxStock = 240, targetStock = 180, buyMax = 300,   restockRate = 12 },
            { id = xi.item.BULB_OF_MHAURA_GARLIC,        initial = 144, maxStock = 240, targetStock = 180, buyMax = 400,   restockRate = 12 },
            { id = xi.item.JUG_OF_SELBINA_MILK,          initial = 144, maxStock = 240, targetStock = 180, buyMax = 300,   restockRate = 12 },
            { id = xi.item.STICK_OF_SELBINA_BUTTER,      initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 300,   restockRate = 0 },
            { id = xi.item.PIECE_OF_PIE_DOUGH,           initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 400,   restockRate = 6 }, -- targetStock assumed
            { id = xi.item.POD_OF_BLUE_PEAS,             initial = 144, maxStock = 240, targetStock = 180, buyMax = 140,   restockRate = 12 },
            { id = xi.item.POPOTO,                       initial = 144, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 12 },
            { id = xi.item.BOX_OF_TARUTARU_RICE,         initial = 144, maxStock = 240, targetStock = 180, buyMax = 300,   restockRate = 12 },
            { id = xi.item.POT_OF_CRYING_MUSTARD,        initial = 144, maxStock = 240, targetStock = 180, buyMax = 140,   restockRate = 12 },
            { id = xi.item.PINCH_OF_DRIED_MARJORAM,      initial = 144, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 12 },
            { id = xi.item.BOTTLE_OF_APPLE_VINEGAR,      initial = 10,  maxStock = 240, targetStock = 180, buyMax = 440,   restockRate = 5 }, -- targetStock assumed
            { id = xi.item.POT_OF_MAPLE_SUGAR,           initial = 0,   maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 0 },
            { id = xi.item.BLOCK_OF_GELATIN,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 3000,  restockRate = 0 },
            { id = xi.item.STICK_OF_CINNAMON,            initial = 108, maxStock = 240, targetStock = 180, buyMax = 1300,  restockRate = 12 },
            { id = xi.item.EAR_OF_MILLIONCORN,           initial = 144, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 12 },
            { id = xi.item.SLICE_OF_HARE_MEAT,           initial = 0,   maxStock = 240, targetStock = 180, buyMax = 160,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_GIANT_SHEEP_MEAT,    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_DHALMEL_MEAT,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHINING_TROUT_1,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 650,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,            initial = 0,   maxStock = 240, targetStock = 180, buyMax = 160,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BIRD_EGG,                     initial = 44,  maxStock = 240, targetStock = 180, buyMax = 280,   restockRate = 10 },
            { id = xi.item.FAERIE_APPLE,                 initial = 48,  maxStock = 240, targetStock = 180, buyMax = 220,   restockRate = 12 },
            { id = xi.item.ROLANBERRY,                   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 600,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LA_THEINE_CABBAGE,            initial = 84,  maxStock = 240, targetStock = 180, buyMax = 120,   restockRate = 12 },
            { id = xi.item.CLUMP_OF_BEAUGREENS,          initial = 84,  maxStock = 240, targetStock = 180, buyMax = 500,   restockRate = 12 },
            { id = xi.item.CLUMP_OF_BATAGREENS,          initial = 4,   maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 2 }, -- targetStock assumed
            { id = xi.item.POT_OF_HONEY,                 initial = 0,   maxStock = 240, targetStock = 180, buyMax = 600,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SMOKED_SALMON,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1100,  restockRate = 2 }, -- targetStock assumed
            { id = xi.item.FROST_TURNIP,                 initial = 0,   maxStock = 240, targetStock = 180, buyMax = 160,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 5760,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WILD_ONION,                   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1950,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SAN_DORIAN_CARROT,            initial = 64,  maxStock = 240, targetStock = 180, buyMax = 160,   restockRate = 2 }, -- targetStock assumed
            { id = xi.item.MITHRAN_TOMATO,               initial = 64,  maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 2 }, -- targetStock assumed
            { id = xi.item.BLUETAIL_1,                   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 9000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MOAT_CARP_1,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.THUNDERMELON,                 initial = 16,  maxStock = 240, targetStock = 180, buyMax = 1625,  restockRate = 2 }, -- targetStock assumed
            { id = xi.item.KAZHAM_PINEAPPLE,             initial = 16,  maxStock = 240, targetStock = 180, buyMax = 300,   restockRate = 2 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_COCKATRICE_MEAT,     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RARAB_TAIL,                   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 120,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.YAGUDO_CHERRY,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 220,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BUNCH_OF_PAMAMAS,             initial = 16,  maxStock = 240, targetStock = 180, buyMax = 400,   restockRate = 2 }, -- targetStock assumed
            { id = xi.item.CRAYFISH_1,                   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,            initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TIGER_COD_1,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WATERMELON,                   initial = 16,  maxStock = 240, targetStock = 180, buyMax = 1000,  restockRate = 2 }, -- targetStock assumed
            { id = xi.item.LOAF_OF_WHITE_BREAD,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LOAF_OF_BLACK_BREAD,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 600,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LOAF_OF_IRON_BREAD,           initial = 0,   maxStock = 241, targetStock = 181, buyMax = 500,   restockRate = 0 },
            { id = xi.item.BRETZEL,                      initial = 0,   maxStock = 240, targetStock = 180, buyMax = 120,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ACORN_COOKIE,                 initial = 0,   maxStock = 240, targetStock = 180, buyMax = 120,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CINNA_COOKIE,                 initial = 0,   maxStock = 240, targetStock = 180, buyMax = 80,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GINGER_COOKIE,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 60,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.APPLE_PIE,                    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PAMAMA_TART,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 15360, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SERVING_OF_ICECAP_ROLANBERRY, initial = 0,   maxStock = 240, targetStock = 180, buyMax = 27720, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_GRILLED_HARE,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 920,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_ROAST_MUTTON,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 3600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DHALMEL_STEAK,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 7200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STRIP_OF_MEAT_JERKY,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 600,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROAST_CARP,                   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROAST_TROUT,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 3000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROAST_PIPIRA,                 initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.NEBIMONITE_BAKE,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 9000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.EEL_KABOB,                    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 15000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TORTILLA,                     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 700,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOILED_CRAB,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 11250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARD_BOILED_EGG,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 400,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROAST_MUSHROOM,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1720,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MEAT_MITHKABOB,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 3600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FISH_MITHKABOB,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 5400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOTTLE_OF_ORANGE_JUICE,       initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOTTLE_OF_APPLE_JUICE,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOTTLE_OF_MELON_JUICE,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 5500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOTTLE_OF_GRAPE_JUICE,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4649,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOTTLE_OF_PINEAPPLE_JUICE,    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOTTLE_OF_TOMATO_JUICE,       initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOTTLE_OF_MULSUM,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAKED_APPLE,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.EAR_OF_ROASTED_CORN,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 620,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAKED_POPOTO,                 initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PICKLED_HERRING,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SERVING_OF_BEAUGREEN_SAUTE,   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 9075,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_PULS,                 initial = 0,   maxStock = 240, targetStock = 180, buyMax = 3000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_VEGETABLE_GRUEL,      initial = 0,   maxStock = 240, targetStock = 180, buyMax = 5000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WINDURST_SALAD,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 9300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_PEBBLE_SOUP,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_PEA_SOUP,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 7000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_VEGETABLE_SOUP,       initial = 0,   maxStock = 240, targetStock = 180, buyMax = 7530,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_MUSHROOM_SOUP,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 35000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_TOMATO_SOUP,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 13230, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOWL_OF_EGG_SOUP,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 16500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SALMON_SUB_SANDWICH,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 5560,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ONZ_OF_TURMERIC,              initial = 40,  maxStock = 120, targetStock = 100, buyMax = 3225,  restockRate = 5 }, -- targetStock assumed
            { id = xi.item.ONZ_OF_CORIANDER,             initial = 40,  maxStock = 120, targetStock = 100, buyMax = 7925,  restockRate = 5 },
            { id = xi.item.SPRIG_OF_HOLY_BASIL,          initial = 20,  maxStock = 60,  targetStock = 50,  buyMax = 4000,  restockRate = 2 },
            { id = xi.item.ONZ_OF_CURRY_POWDER,          initial = 0,   maxStock = 200, targetStock = 180, buyMax = 4950,  restockRate = 0 },
            { id = xi.item.BAG_OF_SEMOLINA,              initial = 84,  maxStock = 240, targetStock = 180, buyMax = 10000, restockRate = 12 },
            { id = xi.item.JAR_OF_FISH_STOCK,            initial = 150, maxStock = 200, targetStock = 150, buyMax = 3050,  restockRate = 100 },
            { id = xi.item.SAUCER_OF_SOY_STOCK,          initial = 150, maxStock = 200, targetStock = 150, buyMax = 3500,  restockRate = 100 },
            { id = xi.item.STICK_OF_VANILLA,             initial = 150, maxStock = 200, targetStock = 150, buyMax = 3600,  restockRate = 100 },
            { id = xi.item.WEDGE_OF_CHALAIMBILLE,        initial = 144, maxStock = 240, targetStock = 180, buyMax = 12675, restockRate = 12 },
        },
    },
    ['Mep_Nhapopoluko'] =
    {
        hours = { 1, 18 },
        stock =
        {
            { id = xi.item.FASTWATER_FISHING_ROD,   initial = 110, maxStock = 200, targetStock = 190, buyMax = 6976,  restockRate = 10 },
            { id = xi.item.SINGLE_HOOK_FISHING_ROD, initial = 110, maxStock = 200, targetStock = 190, buyMax = 64380, restockRate = 10 },
            { id = xi.item.BLUETAIL_1,              initial = 150, maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 100 },
            { id = xi.item.NOBLE_LADY,              initial = 150, maxStock = 200, targetStock = 150, buyMax = 14000, restockRate = 100 },
            { id = xi.item.TRILOBITE,               initial = 150, maxStock = 200, targetStock = 150, buyMax = 800,   restockRate = 100 },
            { id = xi.item.SHALL_SHELL,             initial = 150, maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 100 },
            { id = xi.item.ZAFMLUG_BASS,            initial = 150, maxStock = 200, targetStock = 150, buyMax = 770,   restockRate = 100 },
            { id = xi.item.MOORISH_IDOL,            initial = 150, maxStock = 200, targetStock = 150, buyMax = 14280, restockRate = 100 },
            { id = xi.item.BIBIKIBO,                initial = 150, maxStock = 200, targetStock = 150, buyMax = 2000,  restockRate = 100 },
            { id = xi.item.BIBIKI_URCHIN,           initial = 150, maxStock = 200, targetStock = 150, buyMax = 22500, restockRate = 100 },
            { id = xi.item.CLUMP_OF_PAMTAM_KELP,    initial = 150, maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 100 },
            { id = xi.item.COBALT_JELLYFISH,        initial = 150, maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 100 },
        },
    },
    ['Paunelie'] =
    {
        hours = { 12, 20 },
        stock =
        {
            { id = xi.item.NEW_LINKSHELL,   initial = 75,  maxStock = 100, targetStock = 75,  buyMax = 6000, restockRate = 0, priceFloor = 0, sellPrice = 2250 }, -- Not a typo, they do not restock on retail.
            { id = xi.item.PENDANT_COMPASS, initial = 150, maxStock = 200, targetStock = 150, buyMax = 375,  restockRate = 0, priceFloor = 0, noSell = true },
        },
    },
    ['Scavnix'] =
    {
        hours = { 11, 22 },
        stock =
        {
            { id = xi.item.RED_CHIP,    initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.BLUE_CHIP,   initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.YELLOW_CHIP, initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.GREEN_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.CLEAR_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.PURPLE_CHIP, initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.WHITE_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
            { id = xi.item.BLACK_CHIP,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 140000, restockRate = 50, noSell = true },
        },
    },
    ['Vuliaie'] =
    {
        hours = { 9, 23 },
        stock =
        {
            { id = xi.item.BAMBOO_STICK,            initial = 50,  maxStock = 240, targetStock = 180, buyMax = 720,    restockRate = 10 },
            { id = xi.item.JAR_OF_TOAD_OIL,         initial = 18,  maxStock = 60,  targetStock = 45,  buyMax = 18000,  restockRate = 4 },
            { id = xi.item.SHEET_OF_BAST_PARCHMENT, initial = 10,  maxStock = 60,  targetStock = 45,  buyMax = 5400,   restockRate = 2 },
            { id = xi.item.SQUARE_OF_SILK_CLOTH,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 105000, restockRate = 0 },
            { id = xi.item.HANDFUL_OF_IRON_SAND,    initial = 190, maxStock = 240, targetStock = 190, buyMax = 2370,   restockRate = 60, priceFloor = 270 },
            { id = xi.item.LUMP_OF_TAMA_HAGANE,     initial = 80,  maxStock = 120, targetStock = 100, buyMax = 35000,  restockRate = 10 },
            { id = xi.item.POT_OF_URUSHI,           initial = 14,  maxStock = 60,  targetStock = 45,  buyMax = 367650, restockRate = 2 },
            { id = xi.item.UCHITAKE,                initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 10 },
            { id = xi.item.TSURARA,                 initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 10 },
            { id = xi.item.KAWAHORI_OGI,            initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 10 },
            { id = xi.item.MAKIBISHI,               initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 10 },
            { id = xi.item.HIRAISHIN,               initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 10 },
            { id = xi.item.MIZU_DEPPO,              initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 10 },
            { id = xi.item.SHIHEI,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 620,    restockRate = 0 },
            { id = xi.item.JUSATSU,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 620,    restockRate = 0 },
            { id = xi.item.KAGINAWA,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 620,    restockRate = 0 },
            { id = xi.item.SAIRUI_RAN,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 620,    restockRate = 0 },
            { id = xi.item.KODOKU,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 620,    restockRate = 0 },
            { id = xi.item.SHINOBI_TABI,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 620,    restockRate = 0 },
            { id = xi.item.GARDENIA_SEED,           initial = 150, maxStock = 200, targetStock = 150, buyMax = 2460,   restockRate = 50 },
            { id = xi.item.ONZ_OF_TURMERIC,         initial = 170, maxStock = 240, targetStock = 170, buyMax = 3225,   restockRate = 80 },
            { id = xi.item.ONZ_OF_CORIANDER,        initial = 170, maxStock = 240, targetStock = 170, buyMax = 7924,   restockRate = 80 },
            { id = xi.item.SPRIG_OF_HOLY_BASIL,     initial = 170, maxStock = 240, targetStock = 170, buyMax = 4000,   restockRate = 80 },
            { id = xi.item.ONZ_OF_CURRY_POWDER,     initial = 110, maxStock = 120, targetStock = 110, buyMax = 4950,   restockRate = 50 },
            { id = xi.item.JAR_OF_GROUND_WASABI,    initial = 150, maxStock = 200, targetStock = 150, buyMax = 12967,  restockRate = 100 },
            { id = xi.item.BOTTLE_OF_RICE_VINEGAR,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 1000,   restockRate = 100 },
            { id = xi.item.HEAD_OF_NAPA,            initial = 150, maxStock = 200, targetStock = 150, buyMax = 1250,   restockRate = 100 },
        },
    },
    ['Yabby_Tanmikey'] =
    {
        hours = { 8, 23 },
        stock =
        {
            { id = xi.item.CHUNK_OF_SILVER_ORE,     initial = 100, maxStock = 200, targetStock = 100, buyMax = 2100,   restockRate = 10, priceFloor = 180 },
            { id = xi.item.CHUNK_OF_MYTHRIL_ORE,    initial = 0,   maxStock = 200, targetStock = 100, buyMax = 10000,  restockRate = 0,  priceFloor = 15 },
            { id = xi.item.CHUNK_OF_GOLD_ORE,       initial = 0,   maxStock = 200, targetStock = 100, buyMax = 23100,  restockRate = 0,  priceFloor = 15 },
            { id = xi.item.CHUNK_OF_PLATINUM_ORE,   initial = 0,   maxStock = 200, targetStock = 100, buyMax = 58500,  restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.COPPER_INGOT,            initial = 0,   maxStock = 200, targetStock = 100, buyMax = 600,    restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.BRASS_INGOT,             initial = 0,   maxStock = 200, targetStock = 100, buyMax = 1000,   restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.SILVER_INGOT,            initial = 0,   maxStock = 200, targetStock = 100, buyMax = 10500,  restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_INGOT,           initial = 0,   maxStock = 200, targetStock = 100, buyMax = 50000,  restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.GOLD_INGOT,              initial = 0,   maxStock = 200, targetStock = 100, buyMax = 115500, restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.PLATINUM_INGOT,          initial = 0,   maxStock = 200, targetStock = 100, buyMax = 292500, restockRate = 0,  priceFloor = 15 },
            { id = xi.item.BRASS_SHEET,             initial = 0,   maxStock = 200, targetStock = 100, buyMax = 1200,   restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SHEET,           initial = 0,   maxStock = 200, targetStock = 100, buyMax = 60000,  restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.GOLD_SHEET,              initial = 0,   maxStock = 200, targetStock = 100, buyMax = 371700, restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.PLATINUM_SHEET,          initial = 0,   maxStock = 200, targetStock = 100, buyMax = 581250, restockRate = 0,  priceFloor = 15 },
            { id = xi.item.HANDFUL_OF_BRASS_SCALES, initial = 0,   maxStock = 200, targetStock = 100, buyMax = 1400,   restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.SILVER_CHAIN,            initial = 0,   maxStock = 200, targetStock = 100, buyMax = 78000,  restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_CHAIN,           initial = 0,   maxStock = 200, targetStock = 100, buyMax = 70000,  restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.GOLD_CHAIN,              initial = 0,   maxStock = 200, targetStock = 100, buyMax = 255240, restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.PLATINUM_CHAIN,          initial = 0,   maxStock = 200, targetStock = 100, buyMax = 418500, restockRate = 0,  priceFloor = 15 }, -- targetStock assumed
            { id = xi.item.RED_ROCK,                initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
            { id = xi.item.BLUE_ROCK,               initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
            { id = xi.item.YELLOW_ROCK,             initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
            { id = xi.item.GREEN_ROCK,              initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
            { id = xi.item.TRANSLUCENT_ROCK,        initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
            { id = xi.item.PURPLE_ROCK,             initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
            { id = xi.item.BLACK_ROCK,              initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
            { id = xi.item.WHITE_ROCK,              initial = 5,   maxStock = 60,  targetStock = 35,  buyMax = 7000,   restockRate = 1 },
        },
    },
}
