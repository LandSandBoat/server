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
---@field priceFloor? number    -- buy-curve floor override; defaults to 3/4 of maxStock

---@class GuildShop
---@field hours?      integer[]       -- { openHour, closeHour }  (nil for a sharedStock alias)
---@field stock?      GuildShopItem[] -- nil for a sharedStock alias
---@field holiday?    xi.day          -- weekday the shop closes for its guild holiday (nil for a sharedStock alias)
---@field sharedStock? string         -- alias NPC: draws from this shop's stock pool

---@type table<string, GuildShop>
xi.data.guildShops =
{
    ['Achika'] =
    {
        hours   = { 9, 23 },
        holiday = xi.day.DARKSDAY,
        stock   =
        {
            { id = xi.item.HACHIMAKI,         initial = 36, maxStock = 60, targetStock = 45, buyMax = 4125,   restockRate = 3 },
            { id = xi.item.COTTON_HACHIMAKI,  initial = 36, maxStock = 60, targetStock = 45, buyMax = 24420,  restockRate = 3 },
            { id = xi.item.SOIL_HACHIMAKI,    initial = 36, maxStock = 60, targetStock = 45, buyMax = 66960,  restockRate = 3 },
            { id = xi.item.SHINOBI_HACHIGANE, initial = 0,  maxStock = 60, targetStock = 45, buyMax = 240460, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ZUNARI_KABUTO,     initial = 0,  maxStock = 60, targetStock = 45, buyMax = 180200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.NODOWA,            initial = 0,  maxStock = 60, targetStock = 45, buyMax = 149710, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_NODOWA,  initial = 0,  maxStock = 60, targetStock = 45, buyMax = 285000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KENPOGI,           initial = 36, maxStock = 60, targetStock = 45, buyMax = 6225,   restockRate = 3 },
            { id = xi.item.COTTON_DOGI,       initial = 36, maxStock = 60, targetStock = 45, buyMax = 36800,  restockRate = 3 },
            { id = xi.item.JUJITSU_GI,        initial = 0,  maxStock = 60, targetStock = 45, buyMax = 283500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SOIL_GI,           initial = 36, maxStock = 60, targetStock = 45, buyMax = 99000,  restockRate = 3 },
            { id = xi.item.SHINOBI_GI,        initial = 0,  maxStock = 60, targetStock = 45, buyMax = 363000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARA_ATE,          initial = 0,  maxStock = 60, targetStock = 45, buyMax = 330000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TEKKO,             initial = 36, maxStock = 60, targetStock = 45, buyMax = 3425,   restockRate = 3 },
            { id = xi.item.COTTON_TEKKO,      initial = 36, maxStock = 60, targetStock = 45, buyMax = 20250,  restockRate = 3 },
            { id = xi.item.SOIL_TEKKO,        initial = 36, maxStock = 60, targetStock = 45, buyMax = 55440,  restockRate = 3 },
            { id = xi.item.SHINOBI_TEKKO,     initial = 0,  maxStock = 60, targetStock = 45, buyMax = 199650, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KOTE,              initial = 0,  maxStock = 60, targetStock = 45, buyMax = 181500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SITABAKI,          initial = 36, maxStock = 60, targetStock = 45, buyMax = 4975,   restockRate = 3 },
            { id = xi.item.COTTON_SITABAKI,   initial = 36, maxStock = 60, targetStock = 45, buyMax = 29490,  restockRate = 3 },
            { id = xi.item.SOIL_SITABAKI,     initial = 36, maxStock = 60, targetStock = 45, buyMax = 80640,  restockRate = 3 },
            { id = xi.item.SHINOBI_HAKAMA,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 294525, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HAIDATE,           initial = 0,  maxStock = 60, targetStock = 45, buyMax = 217600, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KYAHAN,            initial = 36, maxStock = 60, targetStock = 45, buyMax = 3175,   restockRate = 3 },
            { id = xi.item.COTTON_KYAHAN,     initial = 36, maxStock = 60, targetStock = 45, buyMax = 18870,  restockRate = 3 },
            { id = xi.item.SOIL_KYAHAN,       initial = 36, maxStock = 60, targetStock = 45, buyMax = 82620,  restockRate = 3 },
            { id = xi.item.HEKO_OBI,          initial = 0,  maxStock = 60, targetStock = 45, buyMax = 2475,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SILVER_OBI,        initial = 0,  maxStock = 60, targetStock = 45, buyMax = 18390,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GOLD_OBI,          initial = 0,  maxStock = 60, targetStock = 45, buyMax = 58880,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BROCADE_OBI,       initial = 0,  maxStock = 60, targetStock = 45, buyMax = 132000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAINBOW_OBI,       initial = 0,  maxStock = 60, targetStock = 45, buyMax = 268800, restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Amulya'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.WATERSDAY,
        stock   =
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
    ['Babubu'] =
    {
        hours   = { 3, 18 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.LITTLE_WORM,             initial = 180, maxStock = 240, targetStock = 180, buyMax = 20,     restockRate = 60 }, -- targetStock assumed
            { id = xi.item.LUGWORM,                 initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,     restockRate = 60 }, -- targetStock assumed
            { id = xi.item.BALL_OF_SARDINE_PASTE,   initial = 144, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.BALL_OF_CRAYFISH_PASTE,  initial = 144, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.BALL_OF_INSECT_PASTE,    initial = 144, maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.BALL_OF_TROUT_PASTE,     initial = 144, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.MEATBALL,                initial = 144, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_SARDINE,        initial = 144, maxStock = 240, targetStock = 180, buyMax = 1425,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_COD,            initial = 144, maxStock = 240, targetStock = 180, buyMax = 1425,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.PEELED_LOBSTER,          initial = 144, maxStock = 240, targetStock = 180, buyMax = 1475,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_BLUETAIL,       initial = 144, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.PEELED_CRAYFISH,         initial = 144, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_MOAT_CARP,      initial = 144, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.FLY_LURE,                initial = 144, maxStock = 240, targetStock = 180, buyMax = 3600,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.MINNOW,                  initial = 144, maxStock = 240, targetStock = 180, buyMax = 2025,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.WORM_LURE,               initial = 144, maxStock = 240, targetStock = 180, buyMax = 3600,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.FROG_LURE,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHRIMP_LURE,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5730,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LIZARD_LURE,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 4590,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SABIKI_RIG,              initial = 144, maxStock = 240, targetStock = 180, buyMax = 15960,  restockRate = 12 }, -- targetStock assumed
            { id = xi.item.WILLOW_FISHING_ROD,      initial = 108, maxStock = 180, targetStock = 160, buyMax = 360,    restockRate = 9 },  -- targetStock assumed
            { id = xi.item.YEW_FISHING_ROD,         initial = 108, maxStock = 180, targetStock = 160, buyMax = 1180,   restockRate = 9 },  -- targetStock assumed
            { id = xi.item.BAMBOO_FISHING_ROD,      initial = 108, maxStock = 180, targetStock = 160, buyMax = 2700,   restockRate = 9 },  -- targetStock assumed
            { id = xi.item.FASTWATER_FISHING_ROD,   initial = 72,  maxStock = 120, targetStock = 100, buyMax = 6975,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD,    initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 27180,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.MITHRAN_FISHING_ROD,     initial = 40,  maxStock = 60,  targetStock = 45,  buyMax = 171600, restockRate = 5 },  -- targetStock assumed
            { id = xi.item.GLASS_FIBER_FISHING_ROD, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 43140,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLOTHESPOLE,             initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 13200,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.SINGLE_HOOK_FISHING_ROD, initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 64380,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,        initial = 144, maxStock = 240, targetStock = 180, buyMax = 160,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.CRAYFISH_1,              initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 200,    restockRate = 6 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP,    initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 160,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MOAT_CARP_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 200,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.FOREST_CARP,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 300,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 160,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHINING_TROUT_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 650,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHEVAL_SALMON,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TRICOLORED_CARP,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1300,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_CARP,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PIPIRA_1,                initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1150,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1300,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DARK_BASS_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1300,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GRIMMONITE,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_EEL_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 800,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZEBRA_EEL,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ICEFISH,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 4590,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SANDFISH,                initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 650,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 775,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.RED_TERRAPIN,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CRESCENT_FISH,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 15400,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_FROG_1,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ELSHIMO_FROG,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1300,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ELSHIMO_NEWT,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 8750,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 20000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 160,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,                  initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CORAL_BUTTERFLY,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GIANT_CATFISH_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.JUNGLE_CATFISH,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MONKE_ONKE_1,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GAVIAL_FISH,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 20000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
        },
    },
    ['Beugungel'] =
    {
        hours   = { 5, 22 },
        holiday = xi.day.FIRESDAY,
        stock   =
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
        hours   = { 11, 22 },
        holiday = xi.day.DARKSDAY,
        stock   =
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
    ['Bornahn'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.ICEDAY,
        stock   =
        {
            { id = xi.item.CHUNK_OF_COPPER_ORE,     initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,     restockRate = 60 }, -- targetStock assumed
            { id = xi.item.CHUNK_OF_ZINC_ORE,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 625,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHUNK_OF_SILVER_ORE,     initial = 180, maxStock = 240, targetStock = 180, buyMax = 2100,   restockRate = 60 }, -- targetStock assumed
            { id = xi.item.CHUNK_OF_MYTHRIL_ORE,    initial = 12,  maxStock = 120, targetStock = 12,  buyMax = 10000,  restockRate = 6 },  -- targetStock assumed
            { id = xi.item.CHUNK_OF_GOLD_ORE,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 23100,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHUNK_OF_PLATINUM_ORE,   initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 58500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_INGOT,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 600,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_INGOT,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_INGOT,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 10500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_INGOT,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 50000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_INGOT,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 115500, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_INGOT,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 292500, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_SHEET,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1200,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_SHEET,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_SHEET,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 371700, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_SHEET,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 581250, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.HANDFUL_OF_BRASS_SCALES, initial = 3,   maxStock = 121, targetStock = 3,   buyMax = 1400,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.SILVER_CHAIN,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 78000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_CHAIN,           initial = 3,   maxStock = 121, targetStock = 3,   buyMax = 70000,  restockRate = 1 },  -- targetStock assumed
            { id = xi.item.GOLD_CHAIN,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 255240, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_CHAIN,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 418500, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.RED_ROCK,                initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.BLUE_ROCK,               initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.YELLOW_ROCK,             initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.GREEN_ROCK,              initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.TRANSLUCENT_ROCK,        initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.PURPLE_ROCK,             initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.BLACK_ROCK,              initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.WHITE_ROCK,              initial = 4,   maxStock = 240, targetStock = 4,   buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.LAPIS_LAZULI,            initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.LIGHT_OPAL,              initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.ONYX,                    initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.AMETHYST,                initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.TOURMALINE,              initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.SARDONYX,                initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.CLEAR_TOPAZ,             initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.AMBER_STONE,             initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.PERIDOT,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GARNET,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETRINE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SPHENE,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TURQUOISE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOSHENITE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.JADEITE,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SUNSTONE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.FLUORITE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHRYSOBERYL,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AQUAMARINE,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZIRCON,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PAINITE,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MOONSTONE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.EMERALD,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.RUBY,                    initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SPINEL,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TOPAZ,                   initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SAPPHIRE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DIAMOND,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DEATHSTONE,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ANGELSTONE,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_EARRING,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_EARRING,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 22500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_EARRING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 87500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 399000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PEARL_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PERIDOT_EARRING,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TOURMALINE_EARRING,      initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SARDONYX_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLEAR_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETHYST_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAPIS_LAZULI_EARRING,    initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMBER_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ONYX_EARRING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OPAL_EARRING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLOOD_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOSHENITE_EARRING,       initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETRINE_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TURQUOISE_EARRING,       initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SPHENE_EARRING,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_RING,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 380,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_RING,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 1000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_RING,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_RING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 22500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_RING,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 87500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_RING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 434000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OPAL_RING,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SARDONYX_RING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TOURMALINE_RING,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLEAR_RING,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETHYST_RING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAPIS_LAZULI_RING,       initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMBER_RING,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ONYX_RING,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_BANGLES,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 133920, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_BANGLES,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 232200, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_HAIRPIN,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 780,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_HAIRPIN,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6475,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_HAIRPIN,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 29325,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_KNUCKLES,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 4500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_BAGHNAKHS,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 8450,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_DAGGER,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 4650,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SAPARA,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3880,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_XIPHOS,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 19575,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_AXE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 7800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_ZAGHNAL,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_ROD,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3450,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_HAMMER,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 11570,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CIRCLET,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 800,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.POETS_CIRCLET,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 10350,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_CAP,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 8175,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_MASK,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 64000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_MASK,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 114000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_HARNESS,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 12425,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_SCALE_MAIL,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 97440,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_MITTENS,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6825,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_MITTENS,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 94000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_FINGER_GAUNTLETS,  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 51840,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_SUBLIGAR,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 10000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_LEGGINGS,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6200,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_CUISSES,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 77280,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_GREAVES,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 45760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_BELT,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 57120,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHAIN_BELT,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 30600,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHAIN_CHOKER,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 24300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHAIN_GORGET,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 30600,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.WORKSHOP_ANVIL,          initial = 180, maxStock = 240, targetStock = 180, buyMax = 500,    restockRate = 60 }, -- targetStock assumed
        },
    },
    ['Cehn_Teyohngo'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.LUGWORM,              initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,    restockRate = 60 }, -- targetStock assumed
            { id = xi.item.SABIKI_RIG,           initial = 20,  maxStock = 120, targetStock = 90,  buyMax = 15960, restockRate = 5 },  -- targetStock assumed
            { id = xi.item.MINNOW,               initial = 20,  maxStock = 60,  targetStock = 50,  buyMax = 2025,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,       initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 5160,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD, initial = 140, maxStock = 240, targetStock = 180, buyMax = 27180, restockRate = 10 }, -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,     initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP, initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 775,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 20000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,               initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,          initial = 0,   maxStock = 40,  targetStock = 30,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
        },
    },
    ['Chaupire'] =
    {
        hours   = { 6, 21 },
        holiday = xi.day.FIRESDAY,
        stock   =
        {
            { id = xi.item.ASH_LOG,                   initial = 144, maxStock = 240, targetStock = 180, buyMax = 480,    restockRate = 12 },
            { id = xi.item.WILLOW_LOG,                initial = 144, maxStock = 240, targetStock = 180, buyMax = 800,    restockRate = 12 },
            { id = xi.item.HOLLY_LOG,                 initial = 108, maxStock = 180, targetStock = 135, buyMax = 3525,   restockRate = 9 },
            { id = xi.item.YEW_LOG,                   initial = 108, maxStock = 180, targetStock = 135, buyMax = 2200,   restockRate = 9 },
            { id = xi.item.ELM_LOG,                   initial = 84,  maxStock = 255, targetStock = 191, buyMax = 11490,  restockRate = 12, priceFloor = 270 },
            { id = xi.item.WALNUT_LOG,                initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 4270,   restockRate = 3 },
            { id = xi.item.CHESTNUT_LOG,              initial = 72,  maxStock = 120, targetStock = 90,  buyMax = 14130,  restockRate = 6 },
            { id = xi.item.OAK_LOG,                   initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 31600,  restockRate = 3 },
            { id = xi.item.ROSEWOOD_LOG,              initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 44100,  restockRate = 3 },
            { id = xi.item.MAHOGANY_LOG,              initial = 16,  maxStock = 60,  targetStock = 45,  buyMax = 60500,  restockRate = 3 },
            { id = xi.item.EBONY_LOG,                 initial = 16,  maxStock = 60,  targetStock = 45,  buyMax = 64000,  restockRate = 3 },
            { id = xi.item.BAMBOO_STICK,              initial = 36,  maxStock = 240, targetStock = 180, buyMax = 720,    restockRate = 12 },
            { id = xi.item.PIECE_OF_RATTAN_LUMBER,    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 800,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_ARROWWOOD_LUMBER, initial = 36,  maxStock = 240, targetStock = 180, buyMax = 20,     restockRate = 12 },
            { id = xi.item.PIECE_OF_LAUAN_LUMBER,     initial = 36,  maxStock = 240, targetStock = 180, buyMax = 180,    restockRate = 12 },
            { id = xi.item.PIECE_OF_MAPLE_LUMBER,     initial = 36,  maxStock = 240, targetStock = 180, buyMax = 300,    restockRate = 12 },
            { id = xi.item.PIECE_OF_ASH_LUMBER,       initial = 35,  maxStock = 240, targetStock = 180, buyMax = 480,    restockRate = 12 },
            { id = xi.item.PIECE_OF_WILLOW_LUMBER,    initial = 36,  maxStock = 240, targetStock = 180, buyMax = 800,    restockRate = 12 },
            { id = xi.item.PIECE_OF_HOLLY_LUMBER,     initial = 27,  maxStock = 180, targetStock = 135, buyMax = 4050,   restockRate = 9 },
            { id = xi.item.PIECE_OF_YEW_LUMBER,       initial = 27,  maxStock = 180, targetStock = 135, buyMax = 2200,   restockRate = 9 },
            { id = xi.item.PIECE_OF_ELM_LUMBER,       initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 11490,  restockRate = 6 },
            { id = xi.item.PIECE_OF_CHESTNUT_LUMBER,  initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 14130,  restockRate = 6 },
            { id = xi.item.PIECE_OF_OAK_LUMBER,       initial = 15,  maxStock = 60,  targetStock = 45,  buyMax = 31600,  restockRate = 6 },
            { id = xi.item.PIECE_OF_WALNUT_LUMBER,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4880,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_ROSEWOOD_LUMBER,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 44100,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_MAHOGANY_LUMBER,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_EBONY_LUMBER,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 64000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_ANCIENT_LUMBER,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 139750, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_CLOGS,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 620,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLLY_CLOGS,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 8125,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHESTNUT_SABOTS,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 45900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.EBONY_SABOTS,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 100800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LAUAN_SHIELD,              initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 600,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_SHIELD,              initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 3024,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ELM_SHIELD,                initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 9075,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAHOGANY_SHIELD,           initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 24900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_SHIELD,                initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 78000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SIMPLE_BED,                initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 8000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WORKBENCH,                 initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 1880,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOOK_HOLDER,               initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 36720,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLOWER_STAND,              initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 1940,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DESK,                      initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 3160,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TARUTARU_DESK,             initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 157500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_TABLE,               initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 5530,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TARUTARU_STOOL,            initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 4920,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_TABLE,                 initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 468000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TRAVERSIERE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 84000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_BED,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 750000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLUTE,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 240,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PICCOLO,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5500,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_HARP,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 240,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARP,                      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROSE_HARP,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 100000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_CLUB,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 360,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHESTNUT_CLUB,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8700,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_CUDGEL,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 56160,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREAT_CLUB,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 110200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_WAND,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 260,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WILLOW_WAND,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1850,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.YEW_WAND,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7830,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHESTNUT_WAND,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 28560,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROSE_WAND,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 74800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHORTBOW,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 220,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SELF_BOW,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2680,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COMPOSITE_BOW,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 131250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KAMAN,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 221850, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LONGBOW,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2460,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WRAPPED_BOW,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 39600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POWER_BOW,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 29730,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREAT_BOW,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 109060, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BATTLE_BOW,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 216000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAR_BOW,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 428400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_STAFF,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 320,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLLY_STAFF,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3175,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ELM_STAFF,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18030,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_STAFF,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 54810,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_POLE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2100,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLLY_POLE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 25380,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ELM_POLE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 91200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_POLE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 187200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPIKED_CLUB,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 52500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.QUARTERSTAFF,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 110250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARPOON,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 540,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SPEAR,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4400,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRASS_SPEAR,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 26000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPEAR,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 88200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HALBERD,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 222750, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LANCE,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 92100,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIGHT_CROSSBOW,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 900,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CROSSBOW,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 11775,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ZAMBURAK,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 76950,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOOMERANG,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8750,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOODEN_ARROW,              initial = 50,  maxStock = 240, targetStock = 180, buyMax = 20,     restockRate = 10 },
            { id = xi.item.IRON_ARROW,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 40,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SILVER_ARROW,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 90,     restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Chiyo'] =
    {
        hours   = { 9, 23 },
        holiday = xi.day.DARKSDAY,
        stock   =
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
            { id = xi.item.SCROLL_OF_UTSUSEMI_ICHI, initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14245,  restockRate = 0 },
            { id = xi.item.SCROLL_OF_JUBAKU_ICHI,   initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_HOJO_ICHI,     initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_KURAYAMI_ICHI, initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_DOKUMORI_ICHI, initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_TONKO_ICHI,    initial = 0,  maxStock = 60, targetStock = 45, buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_MONOMI_ICHI,   initial = 0,  maxStock = 60, targetStock = 45, buyMax = 47950,  restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Dehbi_Moshal'] =
    {
        hours   = { 6, 21 },
        holiday = xi.day.FIRESDAY,
        stock   =
        {
            { id = xi.item.ARROWWOOD_LOG,             initial = 180, maxStock = 240, targetStock = 180, buyMax = 100,    restockRate = 60 },
            { id = xi.item.LAUAN_LOG,                 initial = 144, maxStock = 240, targetStock = 144, buyMax = 180,    restockRate = 12 },
            { id = xi.item.MAPLE_LOG,                 initial = 144, maxStock = 240, targetStock = 144, buyMax = 300,    restockRate = 12 },
            { id = xi.item.ASH_LOG,                   initial = 144, maxStock = 240, targetStock = 144, buyMax = 480,    restockRate = 12 },
            { id = xi.item.WILLOW_LOG,                initial = 144, maxStock = 240, targetStock = 144, buyMax = 800,    restockRate = 12 },
            { id = xi.item.HOLLY_LOG,                 initial = 108, maxStock = 180, targetStock = 108, buyMax = 3525,   restockRate = 9 },
            { id = xi.item.YEW_LOG,                   initial = 108, maxStock = 180, targetStock = 108, buyMax = 2200,   restockRate = 9 },
            { id = xi.item.ELM_LOG,                   initial = 84,  maxStock = 255, targetStock = 84,  buyMax = 11490,  restockRate = 12, priceFloor = 270 },
            { id = xi.item.WALNUT_LOG,                initial = 36,  maxStock = 60,  targetStock = 36,  buyMax = 4270,   restockRate = 3 },
            { id = xi.item.CHESTNUT_LOG,              initial = 72,  maxStock = 120, targetStock = 72,  buyMax = 14130,  restockRate = 6 },
            { id = xi.item.OAK_LOG,                   initial = 36,  maxStock = 60,  targetStock = 36,  buyMax = 31600,  restockRate = 3 },
            { id = xi.item.ROSEWOOD_LOG,              initial = 36,  maxStock = 60,  targetStock = 36,  buyMax = 44100,  restockRate = 3 },
            { id = xi.item.MAHOGANY_LOG,              initial = 16,  maxStock = 60,  targetStock = 16,  buyMax = 60500,  restockRate = 3 },
            { id = xi.item.EBONY_LOG,                 initial = 16,  maxStock = 60,  targetStock = 16,  buyMax = 64000,  restockRate = 3 },
            { id = xi.item.DOGWOOD_LOG,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 100,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLOODWOOD_LOG,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 63000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAMBOO_STICK,              initial = 36,  maxStock = 240, targetStock = 36,  buyMax = 720,    restockRate = 12 },
            { id = xi.item.PIECE_OF_RATTAN_LUMBER,    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 800,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_ARROWWOOD_LUMBER, initial = 36,  maxStock = 240, targetStock = 36,  buyMax = 20,     restockRate = 12 },
            { id = xi.item.PIECE_OF_LAUAN_LUMBER,     initial = 36,  maxStock = 240, targetStock = 36,  buyMax = 180,    restockRate = 12 },
            { id = xi.item.PIECE_OF_MAPLE_LUMBER,     initial = 36,  maxStock = 240, targetStock = 36,  buyMax = 300,    restockRate = 12 },
            { id = xi.item.PIECE_OF_ASH_LUMBER,       initial = 36,  maxStock = 240, targetStock = 36,  buyMax = 480,    restockRate = 12 },
            { id = xi.item.PIECE_OF_WILLOW_LUMBER,    initial = 36,  maxStock = 240, targetStock = 36,  buyMax = 800,    restockRate = 12 },
            { id = xi.item.PIECE_OF_HOLLY_LUMBER,     initial = 27,  maxStock = 180, targetStock = 27,  buyMax = 4050,   restockRate = 9 },
            { id = xi.item.PIECE_OF_YEW_LUMBER,       initial = 27,  maxStock = 180, targetStock = 27,  buyMax = 2200,   restockRate = 9 },
            { id = xi.item.PIECE_OF_ELM_LUMBER,       initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 11490,  restockRate = 6 },
            { id = xi.item.PIECE_OF_CHESTNUT_LUMBER,  initial = 18,  maxStock = 120, targetStock = 18,  buyMax = 14130,  restockRate = 6 },
            { id = xi.item.PIECE_OF_OAK_LUMBER,       initial = 15,  maxStock = 60,  targetStock = 15,  buyMax = 31600,  restockRate = 6 },
            { id = xi.item.PIECE_OF_WALNUT_LUMBER,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4880,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_ROSEWOOD_LUMBER,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 44100,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_MAHOGANY_LUMBER,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_EBONY_LUMBER,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 64000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_ANCIENT_LUMBER,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 139750, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_DOGWOOD_LUMBER,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 100,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_BLOODWOOD_LUMBER, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 61200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_CLOGS,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 620,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLLY_CLOGS,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 8125,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHESTNUT_SABOTS,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 45900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.EBONY_SABOTS,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 100800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LAUAN_SHIELD,              initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 600,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_SHIELD,              initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 3025,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ELM_SHIELD,                initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 9075,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAHOGANY_SHIELD,           initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 24900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_SHIELD,                initial = 0,   maxStock = 30,  targetStock = 22,  buyMax = 78000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SIMPLE_BED,                initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 8000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WORKBENCH,                 initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 1880,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOOK_HOLDER,               initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 36720,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLOWER_STAND,              initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 1940,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DESK,                      initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 3160,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TARUTARU_DESK,             initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 157500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_TABLE,               initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 5530,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TARUTARU_STOOL,            initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 4920,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_TABLE,                 initial = 0,   maxStock = 12,  targetStock = 9,   buyMax = 468000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TRAVERSIERE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 84000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_BED,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 750000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLUTE,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 240,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PICCOLO,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5500,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_HARP,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 240,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARP,                      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROSE_HARP,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 100000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_CLUB,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 360,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHESTNUT_CLUB,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8700,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_CUDGEL,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 56160,  restockRate = 0 }, -- buyMax from Chaupire; targetStock assumed
            { id = xi.item.GREAT_CLUB,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 110200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAPLE_WAND,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 260,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WILLOW_WAND,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1850,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.YEW_WAND,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7830,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHESTNUT_WAND,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 28560,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROSE_WAND,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 74800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHORTBOW,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 220,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SELF_BOW,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2680,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COMPOSITE_BOW,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 131250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KAMAN,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 221850, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LONGBOW,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2460,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WRAPPED_BOW,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 39600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POWER_BOW,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 29730,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREAT_BOW,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 109060, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BATTLE_BOW,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 216000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAR_BOW,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 428400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_STAFF,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 320,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLLY_STAFF,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3175,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ELM_STAFF,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18030,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_STAFF,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 54810,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ASH_POLE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2100,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLLY_POLE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 25380,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ELM_POLE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 91200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OAK_POLE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 187200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPIKED_CLUB,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 52500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.QUARTERSTAFF,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 110250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARPOON,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 540,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SPEAR,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4400,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRASS_SPEAR,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 26000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPEAR,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 88200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HALBERD,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 222750, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LANCE,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 92100,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIGHT_CROSSBOW,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 900,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CROSSBOW,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 11775,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ZAMBURAK,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 76950,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BOOMERANG,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8750,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOODEN_ARROW,              initial = 50,  maxStock = 240, targetStock = 50,  buyMax = 20,     restockRate = 10 },
            { id = xi.item.IRON_ARROW,                initial = 50,  maxStock = 240, targetStock = 50,  buyMax = 40,     restockRate = 10 },
            { id = xi.item.SILVER_ARROW,              initial = 50,  maxStock = 240, targetStock = 50,  buyMax = 90,     restockRate = 10 },
        },
    },
    ['Doggomehr'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.WATERSDAY,
        stock   =
        {
            { id = xi.item.CHUNK_OF_TIN_ORE,         initial = 180, maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 60 },
            { id = xi.item.CHUNK_OF_IRON_ORE,        initial = 144, maxStock = 240, targetStock = 180, buyMax = 4500,   restockRate = 60 },
            { id = xi.item.CHUNK_OF_MYTHRIL_ORE,     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 10000,  restockRate = 0 },                   -- targetStock assumed
            { id = xi.item.HANDFUL_OF_IRON_SAND,     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2370,   restockRate = 0, priceFloor = 270 }, -- targetStock assumed
            { id = xi.item.BRONZE_INGOT,             initial = 36,  maxStock = 240, targetStock = 180, buyMax = 380,    restockRate = 12 },
            { id = xi.item.IRON_INGOT,               initial = 36,  maxStock = 240, targetStock = 180, buyMax = 18000,  restockRate = 12 },
            { id = xi.item.STEEL_INGOT,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 26250,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_INGOT,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 50000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LUMP_OF_TAMA_HAGANE,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 35000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SHEET,             initial = 36,  maxStock = 240, targetStock = 180, buyMax = 460,    restockRate = 12 },
            { id = xi.item.IRON_SHEET,               initial = 36,  maxStock = 240, targetStock = 180, buyMax = 27000,  restockRate = 12 },
            { id = xi.item.STEEL_SHEET,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SHEET,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_SHEET,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 171000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_BRONZE_SCALES, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 540,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_IRON_SCALES,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_STEEL_SCALES,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 49500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_CHAIN,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CHAIN,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 199500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CLAWS,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 63840,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_CLAWS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 148800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CLAWS,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 259200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KATARS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 77440,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_DAGGER,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 780,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DAGGER,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10150,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_DAGGER,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42930,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BASELARD,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 23940,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KRIS,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60480,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.XIPHOS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3360,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GLADIUS,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 94080,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SWORD,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1340,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_SWORD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 39600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SWORD,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 172000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_SWORD,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 451500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BROADSWORD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 117040, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPATHA,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9300,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LONGSWORD,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 46080,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KNIGHTS_SWORD,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 426250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HUNTING_SWORD,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 198720, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLEURET,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 74480,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CLAYMORE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_CLAYMORE,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 210000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CLAYMORE,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 598500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TWO_HANDED_SWORD,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 69630,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREATSWORD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 337900, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_ROD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 500,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROD,                      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13260,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_ROD,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31280,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAR_PICK,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 121800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_PICK,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 443700, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_MACE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 940,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MACE,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_MACE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 90240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_ZAGHNAL,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1720,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ZAGHNAL,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 62700,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCYTHE,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 52980,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SCYTHE,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 310500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FACEGUARD,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7250,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_MASK,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_VISOR,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 136080, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_VISOR,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 246400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_FINGER_GAUNTLETS,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5950,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHAIN_MITTENS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_FINGER_GAUNTLETS,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 111780, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_FINGER_GAUNTLETS,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 202400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_GREAVES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5425,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREAVES,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 38700,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_GREAVES,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 102060, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_GREAVES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 179025, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_CUISSES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8950,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHAIN_HOSE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 63000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_CUISSES,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 186300, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_CUISSES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 351900, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_MAIL,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 11150,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHAINMAIL,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 79200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_SCALE_MAIL,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 208980, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_SCALE_MAIL,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 378400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KITE_SHIELD,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 61200,  restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Gathweeda'] = { sharedStock = 'Wahraga' },
    ['Gaudylox'] =
    {
        hours   = { 11, 22 },
        holiday = xi.day.FIRESDAY,
        stock   =
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
    ['Graegham'] = -- TODO: Initial capture
    {
        hours   = { 3, 18 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.SABIKI_RIG,              initial = 0, maxStock = 240, targetStock = 180, buyMax = 4401,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD,    initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 27180, restockRate = 10 }, -- targetStock assumed
            { id = xi.item.CLOTHESPOLE,             initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 13200, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.FASTWATER_FISHING_ROD,   initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 6970,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CARBON_FISHING_ROD,      initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 64380, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SINGLE_HOOK_FISHING_ROD, initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 64380, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,        initial = 0, maxStock = 240, targetStock = 180, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CRAYFISH_1,              initial = 0, maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP,    initial = 0, maxStock = 240, targetStock = 180, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MOAT_CARP_1,             initial = 0, maxStock = 240, targetStock = 180, buyMax = 200,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,       initial = 0, maxStock = 240, targetStock = 42,  buyMax = 160,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.SHINING_TROUT_1,         initial = 0, maxStock = 240, targetStock = 180, buyMax = 650,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,             initial = 0, maxStock = 240, targetStock = 180, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHEVAL_SALMON,           initial = 0, maxStock = 240, targetStock = 180, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,            initial = 0, maxStock = 240, targetStock = 180, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TRICOLORED_CARP,         initial = 0, maxStock = 240, targetStock = 180, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,       initial = 0, maxStock = 240, targetStock = 180, buyMax = 2000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PIPIRA_1,                initial = 0, maxStock = 240, targetStock = 180, buyMax = 1150,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,             initial = 0, maxStock = 240, targetStock = 180, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DARK_BASS_1,             initial = 0, maxStock = 240, targetStock = 33,  buyMax = 400,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,              initial = 0, maxStock = 240, targetStock = 17,  buyMax = 1300,  restockRate = 1 },  -- targetStock assumed
            { id = xi.item.BLACK_EEL_1,             initial = 0, maxStock = 240, targetStock = 180, buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,              initial = 0, maxStock = 240, targetStock = 180, buyMax = 800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ICEFISH,                 initial = 0, maxStock = 240, targetStock = 180, buyMax = 4590,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,            initial = 0, maxStock = 240, targetStock = 180, buyMax = 775,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.RED_TERRAPIN,            initial = 0, maxStock = 120, targetStock = 14,  buyMax = 9000,  restockRate = 1 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,          initial = 0, maxStock = 120, targetStock = 90,  buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,              initial = 0, maxStock = 240, targetStock = 180, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CRESCENT_FISH,           initial = 0, maxStock = 120, targetStock = 90,  buyMax = 15400, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,              initial = 0, maxStock = 120, targetStock = 90,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_FROG_1,           initial = 0, maxStock = 240, targetStock = 180, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,            initial = 0, maxStock = 240, targetStock = 83,  buyMax = 20000, restockRate = 1 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,           initial = 0, maxStock = 120, targetStock = 90,  buyMax = 27000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,              initial = 0, maxStock = 120, targetStock = 9,   buyMax = 35000, restockRate = 1 },  -- targetStock assumed
            { id = xi.item.GREEDIE,                 initial = 0, maxStock = 240, targetStock = 62,  buyMax = 160,   restockRate = 2 },  -- targetStock assumed
            { id = xi.item.QUUS_1,                  initial = 0, maxStock = 240, targetStock = 180, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GIANT_CATFISH_1,         initial = 0, maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MONKE_ONKE_1,            initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GAVIAL_FISH,             initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 20000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,            initial = 0, maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,        initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,             initial = 0, maxStock = 60,  targetStock = 45,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
        },
    },
    ['Ilita'] =
    {
        hours   = { 12, 20 },
        holiday = xi.day.DARKSDAY,
        stock   =
        {
            { id = xi.item.NEW_LINKSHELL,   initial = 75,  maxStock = 100, targetStock = 75,  buyMax = 6000, restockRate = 0, priceFloor = 0, sellPrice = 2250 }, -- Not a typo, they do not restock on retail.
            { id = xi.item.PENDANT_COMPASS, initial = 150, maxStock = 200, targetStock = 150, buyMax = 375,  restockRate = 0, priceFloor = 0, noSell = true },
        },
    },
    ['Jabbar'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.ICEDAY,
        stock   =
        {
            { id = xi.item.BAMBOO_STICK,            initial = 50,  maxStock = 60,  targetStock = 50,  buyMax = 719,    restockRate = 10 },
            { id = xi.item.JAR_OF_TOAD_OIL,         initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 18000,  restockRate = 0 },
            { id = xi.item.SHEET_OF_BAST_PARCHMENT, initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 5400,   restockRate = 0 },
            { id = xi.item.SQUARE_OF_SILK_CLOTH,    initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 0 },
            { id = xi.item.LUMP_OF_TAMA_HAGANE,     initial = 15,  maxStock = 60,  targetStock = 15,  buyMax = 35000,  restockRate = 0 },
            { id = xi.item.UCHITAKE,                initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 200,    restockRate = 0 },
            { id = xi.item.TSURARA,                 initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 200,    restockRate = 0 },
            { id = xi.item.KAWAHORI_OGI,            initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 200,    restockRate = 0 },
            { id = xi.item.MAKIBISHI,               initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 200,    restockRate = 0 },
            { id = xi.item.HIRAISHIN,               initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 200,    restockRate = 0 },
            { id = xi.item.MIZU_DEPPO,              initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 200,    restockRate = 0 },
            { id = xi.item.SHIHEI,                  initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 625,    restockRate = 0 },
            { id = xi.item.JUSATSU,                 initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 625,    restockRate = 0 },
            { id = xi.item.KAGINAWA,                initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 625,    restockRate = 0 },
            { id = xi.item.SAIRUI_RAN,              initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 625,    restockRate = 0 },
            { id = xi.item.KODOKU,                  initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 625,    restockRate = 0 },
            { id = xi.item.SHINOBI_TABI,            initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 625,    restockRate = 0 },
            { id = xi.item.SCROLL_OF_KATON_ICHI,    initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 11655,  restockRate = 3 },
            { id = xi.item.SCROLL_OF_HYOTON_ICHI,   initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 11655,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_HUTON_ICHI,    initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 11655,  restockRate = 3 },
            { id = xi.item.SCROLL_OF_DOTON_ICHI,    initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 11655,  restockRate = 3 },
            { id = xi.item.SCROLL_OF_RAITON_ICHI,   initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 11655,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_SUITON_ICHI,   initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 11655,  restockRate = 3 },
            { id = xi.item.SCROLL_OF_UTSUSEMI_ICHI, initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_JUBAKU_ICHI,   initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_HOJO_ICHI,     initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_KURAYAMI_ICHI, initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_DOKUMORI_ICHI, initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_TONKO_ICHI,    initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 14245,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_STR,    initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_DEX,    initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_VIT,    initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_AGI,    initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_INT,    initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCROLL_OF_ABSORB_MND,    initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 2 },
            { id = xi.item.SCROLL_OF_ABSORB_CHR,    initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 105000, restockRate = 2 },
            { id = xi.item.ONZ_OF_TURMERIC,         initial = 35,  maxStock = 60,  targetStock = 50,  buyMax = 3225,   restockRate = 15 },
            { id = xi.item.ONZ_OF_CORIANDER,        initial = 35,  maxStock = 60,  targetStock = 50,  buyMax = 7925,   restockRate = 15 },
            { id = xi.item.SPRIG_OF_HOLY_BASIL,     initial = 35,  maxStock = 60,  targetStock = 50,  buyMax = 4000,   restockRate = 15 },
            { id = xi.item.ONZ_OF_CURRY_POWDER,     initial = 18,  maxStock = 30,  targetStock = 25,  buyMax = 1456,   restockRate = 7,   priceFloor = 55 },
            { id = xi.item.JAR_OF_GROUND_WASABI,    initial = 90,  maxStock = 150, targetStock = 120, buyMax = 12974,  restockRate = 20,  priceFloor = 150 },
            { id = xi.item.BOTTLE_OF_RICE_VINEGAR,  initial = 90,  maxStock = 150, targetStock = 120, buyMax = 1000,   restockRate = 20,  priceFloor = 150 },
            { id = xi.item.CLUMP_OF_SHUNGIKU,       initial = 120, maxStock = 150, targetStock = 120, buyMax = 1400,   restockRate = 100, priceFloor = 150 },
            { id = xi.item.SCROLL_OF_MONOMI_ICHI,   initial = 0,   maxStock = 60,  targetStock = 50,  buyMax = 47950,  restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Jidwahn'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.LUGWORM,              initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,    restockRate = 60 }, -- targetStock assumed
            { id = xi.item.SABIKI_RIG,           initial = 20,  maxStock = 120, targetStock = 90,  buyMax = 15960, restockRate = 5 },  -- targetStock assumed
            { id = xi.item.MINNOW,               initial = 20,  maxStock = 60,  targetStock = 50,  buyMax = 2025,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,       initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 5160,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD, initial = 140, maxStock = 240, targetStock = 180, buyMax = 27180, restockRate = 10 }, -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,     initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP, initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 775,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 20000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,               initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,          initial = 0,   maxStock = 40,  targetStock = 30,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KALKANBALIGI,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 78000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KALAMAR,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 8500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.HAMSI,                initial = 0,   maxStock = 200, targetStock = 150, buyMax = 140,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAKERDA,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2575,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KILICBALIGI,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.USKUMRU,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 6000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ICE_CARD,             initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
            { id = xi.item.THUNDER_CARD,         initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
            { id = xi.item.LIGHT_CARD,           initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
            { id = xi.item.DARK_CARD,            initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
        },
    },
    ['Jirokichi'] =
    {
        hours   = { 9, 23 },
        holiday = xi.day.DARKSDAY,
        stock   =
        {
            { id = xi.item.CAT_BAGHNAKHS,   initial = 0,  maxStock = 60, targetStock = 55, buyMax = 580,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRASS_BAGHNAKHS, initial = 0,  maxStock = 60, targetStock = 55, buyMax = 8450,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAGHNAKHS,       initial = 10, maxStock = 60, targetStock = 10, buyMax = 43200,   restockRate = 0 },
            { id = xi.item.CLAWS,           initial = 10, maxStock = 60, targetStock = 10, buyMax = 63840,   restockRate = 0 },
            { id = xi.item.MYTHRIL_CLAWS,   initial = 0,  maxStock = 60, targetStock = 55, buyMax = 148800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CLAWS, initial = 0,  maxStock = 60, targetStock = 55, buyMax = 259200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PATAS,           initial = 10, maxStock = 60, targetStock = 10, buyMax = 228800,  restockRate = 0 },
            { id = xi.item.BONE_PATAS,      initial = 0,  maxStock = 60, targetStock = 55, buyMax = 252150,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GOLD_PATAS,      initial = 0,  maxStock = 60, targetStock = 55, buyMax = 477750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KUNAI,           initial = 50, maxStock = 60, targetStock = 55, buyMax = 4419,    restockRate = 10 },
            { id = xi.item.SUZUME,          initial = 50, maxStock = 60, targetStock = 55, buyMax = 36120,   restockRate = 10 },
            { id = xi.item.HIEN,            initial = 0,  maxStock = 60, targetStock = 55, buyMax = 186000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KAGEBOSHI,       initial = 0,  maxStock = 60, targetStock = 55, buyMax = 215250,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAKIZASHI,       initial = 50, maxStock = 60, targetStock = 55, buyMax = 12000,   restockRate = 10 },
            { id = xi.item.SHINOBI_GATANA,  initial = 50, maxStock = 60, targetStock = 55, buyMax = 23321,   restockRate = 10 },
            { id = xi.item.KODACHI,         initial = 0,  maxStock = 60, targetStock = 55, buyMax = 67200,   restockRate = 0 }, -- targetStock assumed
            -- { id = xi.item.SHINOGI,         initial = 0,  maxStock = 60, targetStock = 55, buyMax = 5400,    restockRate = 0 },  -- sell-only; unsourced, buyMax/targetStock unconfirmed
            { id = xi.item.SAKURAFUBUKI,    initial = 0,  maxStock = 60, targetStock = 55, buyMax = 127050,  restockRate = 0 }, -- targetStock assumed
            -- { id = xi.item.HOCHO,           initial = 0,  maxStock = 60, targetStock = 55, buyMax = 6300,    restockRate = 0 },  -- sell-only; unsourced, buyMax/targetStock unconfirmed
            { id = xi.item.KABUTOWARI,      initial = 0,  maxStock = 60, targetStock = 55, buyMax = 322000,  restockRate = 0 },
            { id = xi.item.UCHIGATANA,      initial = 50, maxStock = 60, targetStock = 55, buyMax = 26680,   restockRate = 10 },
            { id = xi.item.DOTANUKI,        initial = 0,  maxStock = 60, targetStock = 55, buyMax = 715000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KANESADA,        initial = 30, maxStock = 60, targetStock = 55, buyMax = 99000,   restockRate = 10 },
            { id = xi.item.ASHURA,          initial = 0,  maxStock = 60, targetStock = 55, buyMax = 227500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TACHI,           initial = 50, maxStock = 60, targetStock = 55, buyMax = 15695,   restockRate = 10 },
            { id = xi.item.NODACHI,         initial = 20, maxStock = 60, targetStock = 55, buyMax = 40620,   restockRate = 5 },
            { id = xi.item.JINDACHI,        initial = 0,  maxStock = 60, targetStock = 55, buyMax = 722000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OKANEHIRA,       initial = 19, maxStock = 60, targetStock = 55, buyMax = 104730,  restockRate = 7 },
            { id = xi.item.KOTETSU,         initial = 19, maxStock = 60, targetStock = 55, buyMax = 125440,  restockRate = 5 },
            { id = xi.item.HOMURA,          initial = 0,  maxStock = 60, targetStock = 55, buyMax = 207000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MIKAZUKI,        initial = 0,  maxStock = 60, targetStock = 55, buyMax = 317900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DAIHANNYA,       initial = 0,  maxStock = 60, targetStock = 55, buyMax = 816750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ODENTA,          initial = 0,  maxStock = 60, targetStock = 55, buyMax = 494000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOSODACHI,       initial = 0,  maxStock = 60, targetStock = 55, buyMax = 259200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KIKU_ICHIMONJI,  initial = 10, maxStock = 60, targetStock = 10, buyMax = 568700,  restockRate = 0 },
            { id = xi.item.ZANBATO,         initial = 0,  maxStock = 60, targetStock = 55, buyMax = 885500,  restockRate = 0 },
            { id = xi.item.KAZARIDACHI,     initial = 0,  maxStock = 60, targetStock = 55, buyMax = 1073248, restockRate = 0, hidden = true },
            { id = xi.item.KAMAYARI,        initial = 10, maxStock = 60, targetStock = 10, buyMax = 549450,  restockRate = 0 },
            { id = xi.item.WYVERN_SPEAR,    initial = 0,  maxStock = 60, targetStock = 55, buyMax = 397800,  restockRate = 0, hidden = true }, -- targetStock assumed
            { id = xi.item.PIRATES_GUN,     initial = 10, maxStock = 60, targetStock = 10, buyMax = 216000,  restockRate = 0 },
            { id = xi.item.TANEGASHIMA,     initial = 0,  maxStock = 60, targetStock = 55, buyMax = 65310,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.NEGOROSHIKI,     initial = 0,  maxStock = 60, targetStock = 55, buyMax = 660000,  restockRate = 0 },
            { id = xi.item.SHURIKEN,        initial = 40, maxStock = 60, targetStock = 55, buyMax = 250,     restockRate = 5 },
            { id = xi.item.JUJI_SHURIKEN,   initial = 30, maxStock = 60, targetStock = 55, buyMax = 450,     restockRate = 5 },
            { id = xi.item.MANJI_SHURIKEN,  initial = 0,  maxStock = 60, targetStock = 55, buyMax = 1890,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FUMA_SHURIKEN,   initial = 0,  maxStock = 60, targetStock = 55, buyMax = 2000,    restockRate = 0 },
            { id = xi.item.PINWHEEL,        initial = 0,  maxStock = 60, targetStock = 55, buyMax = 1050,    restockRate = 0 },
            { id = xi.item.CHAKRAM,         initial = 0,  maxStock = 60, targetStock = 55, buyMax = 49980,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MOONRING_BLADE,  initial = 0,  maxStock = 60, targetStock = 55, buyMax = 299250,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.QUAKE_GRENADE,   initial = 0,  maxStock = 60, targetStock = 55, buyMax = 18900,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_ARROW,      initial = 20, maxStock = 60, targetStock = 20, buyMax = 40,      restockRate = 0 },
            { id = xi.item.FIRE_ARROW,      initial = 20, maxStock = 60, targetStock = 20, buyMax = 700,     restockRate = 0 },
            { id = xi.item.BULLET,          initial = 10, maxStock = 60, targetStock = 10, buyMax = 500,     restockRate = 0 },
        },
    },
    ['Kamilah'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.WATERSDAY,
        stock   =
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
        hours   = { 12, 20 },
        holiday = xi.day.DARKSDAY,
        stock   =
        {
            { id = xi.item.NEW_LINKSHELL,   initial = 75,  maxStock = 100, targetStock = 75,  buyMax = 6000, restockRate = 0, priceFloor = 0, sellPrice = 2250 }, -- Not a typo, they do not restock on retail.
            { id = xi.item.PENDANT_COMPASS, initial = 150, maxStock = 200, targetStock = 150, buyMax = 375,  restockRate = 0, priceFloor = 0, noSell = true },
        },
    },
    ['Kopopo'] = -- TODO: Recapture initial
    {
        hours   = { 5, 20 },
        holiday = xi.day.DARKSDAY,
        stock   =
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
            { id = xi.item.SMOKED_SALMON,                initial = 4,   maxStock = 240, targetStock = 180, buyMax = 1100,  restockRate = 2 }, -- targetStock assumed
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
            { id = xi.item.LOAF_OF_WHITE_BREAD,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 1000,  restockRate = 0 },
            { id = xi.item.LOAF_OF_BLACK_BREAD,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 600,   restockRate = 0 },
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
            { id = xi.item.SPRIG_OF_HOLY_BASIL,          initial = 19,  maxStock = 60,  targetStock = 50,  buyMax = 4000,  restockRate = 2 },
            { id = xi.item.ONZ_OF_CURRY_POWDER,          initial = 0,   maxStock = 200, targetStock = 180, buyMax = 4950,  restockRate = 0 },
            { id = xi.item.BAG_OF_SEMOLINA,              initial = 84,  maxStock = 240, targetStock = 180, buyMax = 10000, restockRate = 12 },
            { id = xi.item.JAR_OF_FISH_STOCK,            initial = 150, maxStock = 200, targetStock = 150, buyMax = 3050,  restockRate = 100 },
            { id = xi.item.SAUCER_OF_SOY_STOCK,          initial = 150, maxStock = 200, targetStock = 150, buyMax = 3500,  restockRate = 100 },
            { id = xi.item.STICK_OF_VANILLA,             initial = 155, maxStock = 200, targetStock = 150, buyMax = 3600,  restockRate = 100 },
            { id = xi.item.WEDGE_OF_CHALAIMBILLE,        initial = 144, maxStock = 240, targetStock = 180, buyMax = 12675, restockRate = 12 },
        },
    },
    ['Kueh_Igunahmori'] =
    {
        hours   = { 3, 18 },
        holiday = xi.day.ICEDAY,
        stock   =
        {
            { id = xi.item.DHALMEL_HIDE,                  initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOLF_HIDE,                     initial = 90,  maxStock = 120, targetStock = 90,  buyMax = 3225,   restockRate = 6 },
            { id = xi.item.RAM_SKIN,                      initial = 90,  maxStock = 120, targetStock = 90,  buyMax = 6250,   restockRate = 6 },
            { id = xi.item.TIGER_HIDE,                    initial = 57,  maxStock = 120, targetStock = 57,  buyMax = 8750,   restockRate = 6 },
            { id = xi.item.COEURL_HIDE,                   initial = 66,  maxStock = 120, targetStock = 66,  buyMax = 18000,  restockRate = 6 },
            { id = xi.item.MANTICORE_HIDE,                initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 45600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_SHEEP_LEATHER,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_DHALMEL_LEATHER,     initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 11650,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_RAM_LEATHER,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18120,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_BLACK_TIGER_LEATHER, initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 23040,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_COEURL_LEATHER,      initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 38610,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_MANTICORE_LEATHER,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 55900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_SKIN,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1625,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAPTOR_SKIN,                   initial = 45,  maxStock = 60,  targetStock = 45,  buyMax = 14370,  restockRate = 2 },
            { id = xi.item.COCKATRICE_SKIN,               initial = 45,  maxStock = 60,  targetStock = 45,  buyMax = 17670,  restockRate = 2 },
            { id = xi.item.CLUMP_OF_SHEEP_WOOL,           initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4500,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WILLOW_LOG,                    initial = 180, maxStock = 240, targetStock = 180, buyMax = 800,    restockRate = 60 },
            { id = xi.item.FLASK_OF_DISTILLED_WATER,      initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,     restockRate = 60 },
            { id = xi.item.SHEET_OF_PARCHMENT,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2575,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RABBIT_MANTLE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 880,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DHALMEL_MANTLE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 16559,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOLF_MANTLE,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42840,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAM_MANTLE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 72000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_MANTLE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13770,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAPTOR_MANTLE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 160000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_BELT,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_BELT,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2125,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WARRIORS_BELT,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 52800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MAGIC_BELT,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 15180,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BARBARIANS_BELT,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 15180,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAISTBELT,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 92400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_GORGET,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1320,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOLF_GORGET,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42560,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_VEST,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3220,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_JERKIN,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 34300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STUDDED_VEST,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 114000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRIGANDINE_ARMOR,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 294000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUIR_BOUILLI,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 215600, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAPTOR_JERKIN,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 296400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_HIGHBOOTS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1680,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STUDDED_BOOTS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 55860,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUIR_HIGHBOOTS,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 104160, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SANDALS,                       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22440,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHOES,                         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 71760,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MOCCASINS,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 204000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_GLOVES,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1800,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_GLOVES,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STUDDED_GLOVES,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 59850,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUIR_GLOVES,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 113680, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAPTOR_GLOVES,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 198000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_BANDANA,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2080,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_HELM,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22125,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STUDDED_BANDANA,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 71630,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUIR_BANDANA,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 109200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAPTOR_HELM,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 246400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_TROUSERS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2680,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_TROUSERS,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 27195,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STUDDED_TROUSERS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 72960,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUIR_TROUSERS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 166320, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAPTOR_TROUSERS,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 280800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SOLEA,                         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3025,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_LEDELSENS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 17190,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAPTOR_LEDELSENS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 184800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CESTI,                         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 720,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIZARD_CESTI,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6300,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HIMANTES,                      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 79800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_RING,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6250,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LEATHER_SHIELD,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 172800, restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Kuzah_Hpirohpon'] =
    {
        hours   = { 6, 21 },
        holiday = xi.day.FIRESDAY,
        stock   =
        {
            { id = xi.item.BALL_OF_SARUTA_COTTON,   initial = 2,   maxStock = 240, targetStock = 18,  buyMax = 200,    restockRate = 1 },
            { id = xi.item.FLAX_FLOWER,             initial = 180, maxStock = 240, targetStock = 180, buyMax = 1250,   restockRate = 30 },
            { id = xi.item.CLUMP_OF_SHEEP_WOOL,     initial = 180, maxStock = 240, targetStock = 180, buyMax = 4500,   restockRate = 30 },
            { id = xi.item.PIECE_OF_CRAWLER_COCOON, initial = 60,  maxStock = 240, targetStock = 140, buyMax = 930,    restockRate = 10 },
            { id = xi.item.SPIDER_WEB,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 30738,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPOOL_OF_GRASS_THREAD,   initial = 180, maxStock = 240, targetStock = 180, buyMax = 300,    restockRate = 30 },
            { id = xi.item.SPOOL_OF_COTTON_THREAD,  initial = 132, maxStock = 240, targetStock = 132, buyMax = 800,    restockRate = 6 },
            { id = xi.item.SPOOL_OF_LINEN_THREAD,   initial = 102, maxStock = 180, targetStock = 135, buyMax = 5000,   restockRate = 6 },
            { id = xi.item.SPOOL_OF_WOOL_THREAD,    initial = 66,  maxStock = 120, targetStock = 90,  buyMax = 18000,  restockRate = 3 },
            { id = xi.item.SPOOL_OF_SILK_THREAD,    initial = 8,   maxStock = 30,  targetStock = 15,  buyMax = 4060,   restockRate = 1, priceFloor = 9 },
            { id = xi.item.SPOOL_OF_SILVER_THREAD,  initial = 6,   maxStock = 30,  targetStock = 13,  buyMax = 5000,   restockRate = 1, priceFloor = 7.5 },
            { id = xi.item.SPOOL_OF_GOLD_THREAD,    initial = 5,   maxStock = 10,  targetStock = 7,   buyMax = 114000, restockRate = 1 },
            { id = xi.item.SPOOL_OF_RAINBOW_THREAD, initial = 0,   maxStock = 10,  targetStock = 7,   buyMax = 277200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_GRASS_CLOTH,   initial = 36,  maxStock = 240, targetStock = 180, buyMax = 1600,   restockRate = 12 },
            { id = xi.item.SQUARE_OF_COTTON_CLOTH,  initial = 36,  maxStock = 240, targetStock = 180, buyMax = 3200,   restockRate = 12 },
            { id = xi.item.SQUARE_OF_LINEN_CLOTH,   initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 15000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_WOOL_CLOTH,    initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 54000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_VELVET_CLOTH,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 79750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_SILK_CLOTH,    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_RAINBOW_CLOTH, initial = 0,   maxStock = 240, targetStock = 180, buyMax = 567675, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BIRD_FEATHER,            initial = 0,   maxStock = 240, targetStock = 180, buyMax = 40,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.YAGUDO_FEATHER,          initial = 0,   maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GIANT_BIRD_FEATHER,      initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4590,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TUNIC,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_TUNIC,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51780,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DOUBLET,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13684,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_DOUBLET,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 68640,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_DOUBLET,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 137940, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GAMBISON,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 162500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_GAMBISON,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 343200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROBE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1200,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_ROBE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 15425,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_ROBE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 90440,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_ROBE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 191520, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CLOAK,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 166060, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GAITERS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7050,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_GAITERS,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 36050,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SOCKS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 80000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_SOCKS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 176000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GLOVES,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7575,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_GLOVES,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 37200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRACERS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 50400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_BRACERS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 189200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUFFS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 660,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_CUFFS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8725,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_CUFFS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51170,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_CUFFS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 108360, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MITTS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3275,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_MITTS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 78659,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_MITTS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 216750, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HEADGEAR,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9800,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_HEADGEAR,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 44590,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_HEADBAND,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLAX_HEADBAND,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 80000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCARLET_RIBBON,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6250,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RED_CAP,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 100000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_CAP,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 196348, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_HAT,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60690,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_HAT,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 128520, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRAIS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10550,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_BRAIS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 54000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOSE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 122500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_HOSE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 288000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLOPS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 959,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_SLOPS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_SLOPS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 73780,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_SLOPS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 156240, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLACKS,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4675,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_SLACKS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 113160, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_SLACKS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 34500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CAPE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2125,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_CAPE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 15180,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_CAPE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 55440,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RED_CAPE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 108900, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FEATHER_COLLAR,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2075,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HEMP_GORGET,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5400,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WING_EARRING,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 48000,  restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Lokhong'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.LUGWORM,              initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,    restockRate = 60 }, -- targetStock assumed
            { id = xi.item.SABIKI_RIG,           initial = 20,  maxStock = 120, targetStock = 90,  buyMax = 15960, restockRate = 5 },  -- targetStock assumed
            { id = xi.item.MINNOW,               initial = 20,  maxStock = 60,  targetStock = 50,  buyMax = 2025,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,       initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 5160,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD, initial = 140, maxStock = 240, targetStock = 180, buyMax = 27180, restockRate = 10 }, -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,     initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP, initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 775,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 20000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,               initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,          initial = 0,   maxStock = 40,  targetStock = 30,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
        },
    },
    ['Maymunah'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.LIGHTSDAY,
        stock   =
        {
            { id = xi.item.LUMP_OF_BEESWAX,           initial = 0,   maxStock = 240, targetStock = 180, buyMax = 600,    restockRate = 0 },
            { id = xi.item.MALBORO_VINE,              initial = 8,   maxStock = 60,  targetStock = 45,  buyMax = 7230,   restockRate = 1 },
            { id = xi.item.BAT_WING,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 300,    restockRate = 0 },
            { id = xi.item.GIANT_STINGER,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 4050,   restockRate = 0 },
            { id = xi.item.PINCH_OF_BOMB_ASH,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2575,   restockRate = 0 },
            { id = xi.item.PINCH_OF_SULFUR,           initial = 40,  maxStock = 120, targetStock = 90,  buyMax = 3825,   restockRate = 6 },
            { id = xi.item.BLOCK_OF_ANIMAL_GLUE,      initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 600,    restockRate = 0 },
            { id = xi.item.WIJNRUIT,                  initial = 58,  maxStock = 240, targetStock = 180, buyMax = 600,    restockRate = 4 },
            { id = xi.item.POT_OF_CRYING_MUSTARD,     initial = 58,  maxStock = 240, targetStock = 180, buyMax = 140,    restockRate = 4 },
            { id = xi.item.PINCH_OF_DRIED_MARJORAM,   initial = 58,  maxStock = 240, targetStock = 180, buyMax = 240,    restockRate = 4 },
            { id = xi.item.CHAMOMILE,                 initial = 58,  maxStock = 240, targetStock = 180, buyMax = 650,    restockRate = 4 },
            { id = xi.item.VIAL_OF_SLIME_OIL,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5000,   restockRate = 0 },
            { id = xi.item.POT_OF_SILENT_OIL,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6000,   restockRate = 0 },
            { id = xi.item.SPRIG_OF_SAGE,             initial = 120, maxStock = 240, targetStock = 180, buyMax = 925,    restockRate = 12 },
            { id = xi.item.CERMET_CHUNK,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 20000,  restockRate = 0 },
            { id = xi.item.COBALT_JELLYFISH,          initial = 18,  maxStock = 240, targetStock = 180, buyMax = 160,    restockRate = 6 },
            { id = xi.item.LOOP_OF_GLASS_FIBER,       initial = 36,  maxStock = 240, targetStock = 180, buyMax = 4000,   restockRate = 6 },
            { id = xi.item.LOOP_OF_CARBON_FIBER,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6000,   restockRate = 0 },
            { id = xi.item.FLASK_OF_DISTILLED_WATER,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60,     restockRate = 0 },
            { id = xi.item.FLASK_OF_HOLY_WATER,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 14500,  restockRate = 0 },
            { id = xi.item.PINCH_OF_POISON_DUST,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1600,   restockRate = 0 },
            { id = xi.item.FLASK_OF_POISON_POTION,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2500,   restockRate = 0 },
            { id = xi.item.ANTIDOTE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1580,   restockRate = 0 },
            { id = xi.item.FLASK_OF_EYE_DROPS,        initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12255,  restockRate = 0 },
            { id = xi.item.FLASK_OF_SILENCING_POTION, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4500,   restockRate = 0 },
            { id = xi.item.FLASK_OF_ECHO_DROPS,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4000,   restockRate = 0 },
            { id = xi.item.JAR_OF_FIRESAND,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22400,  restockRate = 0 },
            { id = xi.item.FLASH_OF_VITRIOL,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2400,   restockRate = 0 },
            { id = xi.item.JAR_OF_BLACK_INK,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3800,   restockRate = 0 },
            { id = xi.item.FLASK_OF_DEODORIZER,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4800,   restockRate = 0 },
            { id = xi.item.POTION,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4550,   restockRate = 0 },
            { id = xi.item.HI_POTION,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22500,  restockRate = 0 },
            { id = xi.item.ETHER,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24160,  restockRate = 0 },
            { id = xi.item.PINCH_OF_PRISM_POWDER,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7000,   restockRate = 0 },
            { id = xi.item.ARTIFICIAL_LENS,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6200,   restockRate = 0 },
            { id = xi.item.WAX_SWORD,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1340,   restockRate = 0 },
            { id = xi.item.BEE_SPATHA,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 17625,  restockRate = 0 },
            { id = xi.item.SILENCE_DAGGER,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10150,  restockRate = 0 },
            { id = xi.item.SILENCE_BAGHNAKHS,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24750,  restockRate = 0 },
            { id = xi.item.FLAME_CLAYMORE,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24475,  restockRate = 0 },
            { id = xi.item.BLIND_DAGGER,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2000,   restockRate = 0 },
            { id = xi.item.BLIND_KNIFE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3375,   restockRate = 0 },
            { id = xi.item.POISON_BASELARD,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 33000,  restockRate = 0 },
            { id = xi.item.POISON_KNIFE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 36780,  restockRate = 0 },
            { id = xi.item.POISON_DAGGER,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 28770,  restockRate = 0 },
            { id = xi.item.POISON_KUKRI,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 48600,  restockRate = 0 },
            { id = xi.item.POISON_CESTI,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 34720,  restockRate = 0 },
            { id = xi.item.POISON_BAGHNAKHS,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 82940,  restockRate = 0 },
            { id = xi.item.POISON_CLAWS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 96000,  restockRate = 0 },
            { id = xi.item.POISON_KATARS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 110880, restockRate = 0 },
            { id = xi.item.FIRE_SWORD,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 39600,  restockRate = 0 },
            { id = xi.item.FLAME_BLADE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 426250, restockRate = 0 },
            { id = xi.item.FLAME_DEGEN,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 216000, restockRate = 0 },
            { id = xi.item.INFERNO_AXE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8725,   restockRate = 0 },
            { id = xi.item.INFERNO_SWORD,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 122080, restockRate = 0 },
            { id = xi.item.ACID_DAGGER,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51510,  restockRate = 0 },
            { id = xi.item.ACID_KNIFE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 86800,  restockRate = 0 },
            { id = xi.item.ACID_CLAWS,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 148800, restockRate = 0 },
            { id = xi.item.HOLY_SWORD,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 172000, restockRate = 0 },
            { id = xi.item.HOLY_DEGEN,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 280000, restockRate = 0 },
            { id = xi.item.HOLY_MACE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 155100, restockRate = 0 },
            { id = xi.item.FIRE_ARROW,                initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 700,    restockRate = 0 },
            { id = xi.item.ICE_ARROW,                 initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 700,    restockRate = 0 },
            { id = xi.item.LIGHTNING_ARROW,           initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 700,    restockRate = 0 },
            { id = xi.item.BRONZE_BULLET,             initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 135,    restockRate = 0 },
            { id = xi.item.BULLET,                    initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 500,    restockRate = 0 },
            { id = xi.item.SILVER_BULLET,             initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 2480,   restockRate = 0 },
            { id = xi.item.GRENADE,                   initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 6020,   restockRate = 0 },
            { id = xi.item.RIOT_GRENADE,              initial = 0,   maxStock = 240, targetStock = 45,  buyMax = 30000,  restockRate = 0 },
            { id = xi.item.BATTERY,                   initial = 60,  maxStock = 240, targetStock = 180, buyMax = 760,    restockRate = 60 },
            { id = xi.item.HYDRO_PUMP,                initial = 60,  maxStock = 240, targetStock = 180, buyMax = 760,    restockRate = 60 },
            { id = xi.item.WIND_FAN,                  initial = 60,  maxStock = 240, targetStock = 180, buyMax = 140,    restockRate = 60 },
        },
    },
    ['Mendoline'] = { sharedStock = 'Graegham' },
    ['Mep_Nhapopoluko'] =
    {
        hours   = { 1, 18 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
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
    ['Ndego'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.WATERSDAY,
        stock   =
        {
            { id = xi.item.CHUNK_OF_COPPER_ORE,      initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,     restockRate = 60 },
            { id = xi.item.CHUNK_OF_TIN_ORE,         initial = 180, maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 60 },
            { id = xi.item.CHUNK_OF_IRON_ORE,        initial = 180, maxStock = 240, targetStock = 180, buyMax = 4500,   restockRate = 60 },
            { id = xi.item.CHUNK_OF_MYTHRIL_ORE,     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 10000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_IRON_SAND,     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2370,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_INGOT,             initial = 36,  maxStock = 240, targetStock = 180, buyMax = 380,    restockRate = 12 },
            { id = xi.item.IRON_INGOT,               initial = 36,  maxStock = 240, targetStock = 180, buyMax = 18000,  restockRate = 12 },
            { id = xi.item.STEEL_INGOT,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 26250,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_INGOT,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 50000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LUMP_OF_TAMA_HAGANE,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 35000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SHEET,             initial = 36,  maxStock = 240, targetStock = 180, buyMax = 460,    restockRate = 12 },
            { id = xi.item.IRON_SHEET,               initial = 36,  maxStock = 240, targetStock = 180, buyMax = 27000,  restockRate = 12 },
            { id = xi.item.STEEL_SHEET,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SHEET,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_SHEET,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 171000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_BRONZE_SCALES, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 540,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_IRON_SCALES,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_STEEL_SCALES,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 49500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_CHAIN,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CHAIN,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 199500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CLAWS,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 63840,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_CLAWS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 148800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CLAWS,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 259200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KATARS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 77440,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_DAGGER,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 780,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DAGGER,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10150,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_DAGGER,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42930,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BASELARD,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 23940,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KRIS,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60480,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.XIPHOS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3360,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GLADIUS,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 94080,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_SWORD,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1340,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_SWORD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 39600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SWORD,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 172000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_SWORD,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 451500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BROADSWORD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 117040, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPATHA,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9300,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LONGSWORD,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 46080,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KNIGHTS_SWORD,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 426250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HUNTING_SWORD,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 198720, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLEURET,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 74480,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CLAYMORE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_CLAYMORE,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 210000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_CLAYMORE,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 598500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TWO_HANDED_SWORD,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 69630,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREATSWORD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 337900, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_ROD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 500,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROD,                      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13260,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_ROD,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31280,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAR_PICK,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 121800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_PICK,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 443700, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_MACE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 940,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MACE,                     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_MACE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 90240,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_ZAGHNAL,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1720,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ZAGHNAL,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 62700,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCYTHE,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 52980,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MYTHRIL_SCYTHE,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 310500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FACEGUARD,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7250,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_MASK,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_VISOR,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 136080, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_VISOR,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 246400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_FINGER_GAUNTLETS,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5950,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHAIN_MITTENS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 42300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_FINGER_GAUNTLETS,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 111780, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_FINGER_GAUNTLETS,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 202400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_GREAVES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5425,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GREAVES,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 38700,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_GREAVES,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 102060, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_GREAVES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 179025, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_CUISSES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8950,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHAIN_HOSE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 63000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_CUISSES,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 186300, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_CUISSES,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 351900, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCALE_MAIL,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 11150,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHAINMAIL,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 79200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IRON_SCALE_MAIL,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 208980, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.STEEL_SCALE_MAIL,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 378400, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KITE_SHIELD,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 61200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MANDREL,                  initial = 180, maxStock = 240, targetStock = 180, buyMax = 500,    restockRate = 60 },
            { id = xi.item.WORKSHOP_ANVIL,           initial = 180, maxStock = 240, targetStock = 180, buyMax = 500,    restockRate = 60 },
        },
    },
    ['Pashi_Maccaleh'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.LUGWORM,              initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,    restockRate = 60 }, -- targetStock assumed
            { id = xi.item.SABIKI_RIG,           initial = 20,  maxStock = 120, targetStock = 90,  buyMax = 15960, restockRate = 5 },  -- targetStock assumed
            { id = xi.item.MINNOW,               initial = 20,  maxStock = 60,  targetStock = 50,  buyMax = 2025,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,       initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 5160,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD, initial = 140, maxStock = 240, targetStock = 180, buyMax = 27180, restockRate = 10 }, -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,     initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP, initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 775,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 20000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,               initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,          initial = 0,   maxStock = 40,  targetStock = 30,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
        },
    },
    ['Paunelie'] =
    {
        hours   = { 12, 20 },
        holiday = xi.day.DARKSDAY,
        stock   =
        {
            { id = xi.item.NEW_LINKSHELL,   initial = 75,  maxStock = 100, targetStock = 75,  buyMax = 6000, restockRate = 0, priceFloor = 0, sellPrice = 2250 }, -- Not a typo, they do not restock on retail.
            { id = xi.item.PENDANT_COMPASS, initial = 150, maxStock = 200, targetStock = 150, buyMax = 375,  restockRate = 0, priceFloor = 0, noSell = true },
        },
    },
    ['Rajmonda'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.LUGWORM,              initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,    restockRate = 60 }, -- targetStock assumed
            { id = xi.item.SABIKI_RIG,           initial = 20,  maxStock = 120, targetStock = 90,  buyMax = 15960, restockRate = 5 },  -- targetStock assumed
            { id = xi.item.MINNOW,               initial = 20,  maxStock = 60,  targetStock = 50,  buyMax = 2025,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,       initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 5160,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD, initial = 140, maxStock = 240, targetStock = 180, buyMax = 27180, restockRate = 10 }, -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,     initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP, initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 775,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 20000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,               initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,          initial = 0,   maxStock = 40,  targetStock = 30,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
        },
    },
    ['Scavnix'] =
    {
        hours   = { 11, 22 },
        holiday = xi.day.LIGHTSDAY,
        stock   =
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
    ['Shih_Tayuun'] = -- TODO: Recapture initial
    {

        hours   = { 8, 23 },
        holiday = xi.day.WINDSDAY,
        stock   =
        {
            { id = xi.item.CRAB_SHELL,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 11490,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHEEP_TOOTH,       initial = 36,  maxStock = 240, targetStock = 143, buyMax = 1000,   restockRate = 12 },
            { id = xi.item.BLACK_TIGER_FANG,  initial = 0,   maxStock = 180, targetStock = 135, buyMax = 12900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TURTLE_SHELL,      initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 78000,  restockRate = 0 },
            { id = xi.item.SEASHELL,          initial = 180, maxStock = 240, targetStock = 180, buyMax = 600,    restockRate = 60 },
            { id = xi.item.BEETLE_SHELL,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1625,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GIANT_FEMUR,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5075,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_JAW,        initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3025,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAM_HORN,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCORPION_SHELL,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12780,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCORPION_CLAW,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8190,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHICKEN_BONE,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 200,    restockRate = 0 },
            { id = xi.item.BONE_HARNESS,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 30770,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_HARNESS,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 58875,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CARAPACE_HARNESS,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 288750, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.JUSTAUCORPS,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 537500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_LEGGINGS,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 14850,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_LEGGINGS,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 28980,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CARAPACE_LEGGINGS, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 147000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHELL_EARRING,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3770,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_EARRING,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9060,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_EARRING,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 17670,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TORTOISE_EARRING,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 87500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_MITTENS,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 16320,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_MITTENS,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 31020,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CARAPACE_MITTENS,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 157500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_MASK,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 19560,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_MASK,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 38190,  restockRate = 0 },
            { id = xi.item.CARAPACE_MASK,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 199500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_HAIRPIN,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2240,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HORN_HAIRPIN,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 85500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHELL_HAIRPIN,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FANG_NECKLACE,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 19034,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_GORGET,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CARAPACE_GORGET,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 115500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_SUBLIGAR,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 23530,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_SUBLIGAR,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 47100,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CARAPACE_SUBLIGAR, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 231000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TURTLE_SHIELD,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 36899,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHELL_RING,        initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3775,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_RING,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9059,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_RING,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18360,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HORN_RING,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 48000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CARAPACE_RING,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 99660,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCORPION_RING,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 94500,  restockRate = 0 },
            { id = xi.item.TURTLE_BANGLES,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 183260, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_KNIFE,        initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 150000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEETLE_KNIFE,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 215250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_AXE,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 23575,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_PICK,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 32580,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CAT_BAGHNAKHS,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 580,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAGHNAKHS,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 43200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRASS_BAGHNAKHS,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8450,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HORN,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 144300, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_ROD,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 56100,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_CUDGEL,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 26880,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BANDITS_GUN,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 50000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BONE_ARROW,        initial = 20,  maxStock = 240, targetStock = 180, buyMax = 25,     restockRate = 10 },
            { id = xi.item.ASTRAGALOS,        initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2520,   restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Silver_Owl'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.ICEDAY,
        stock   =
        {
            { id = xi.item.CAT_BAGHNAKHS,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 580,     restockRate = 0 },                -- targetStock assumed
            { id = xi.item.BRASS_BAGHNAKHS,   initial = 0,  maxStock = 30, targetStock = 25, buyMax = 8450,    restockRate = 0 },                -- targetStock assumed
            { id = xi.item.BAGHNAKHS,         initial = 0,  maxStock = 30, targetStock = 25, buyMax = 43200,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.CLAWS,             initial = 0,  maxStock = 30, targetStock = 25, buyMax = 63840,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.MYTHRIL_CLAWS,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 148800,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.DARKSTEEL_CLAWS,   initial = 0,  maxStock = 30, targetStock = 25, buyMax = 259200,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.PATAS,             initial = 0,  maxStock = 30, targetStock = 25, buyMax = 228800,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.BONE_PATAS,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 252150,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.GOLD_PATAS,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 477750,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.KUNAI,             initial = 20, maxStock = 30, targetStock = 25, buyMax = 4420,    restockRate = 5 },
            { id = xi.item.SUZUME,            initial = 0,  maxStock = 30, targetStock = 25, buyMax = 36120,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.HIEN,              initial = 0,  maxStock = 30, targetStock = 25, buyMax = 186000,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.KAGEBOSHI,         initial = 0,  maxStock = 30, targetStock = 25, buyMax = 215250,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.WAKIZASHI,         initial = 0,  maxStock = 30, targetStock = 25, buyMax = 12000,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.SHINOBI_GATANA,    initial = 20, maxStock = 30, targetStock = 25, buyMax = 23325,   restockRate = 5 },
            { id = xi.item.KODACHI,           initial = 0,  maxStock = 30, targetStock = 25, buyMax = 67200,   restockRate = 0 },                -- targetStock assumed
            -- { id = xi.item.SHINOGI,           initial = 0,  maxStock = 30, targetStock = 25, buyMax = 0,      restockRate = 0 }, -- unsourced (missing on Jirokichi too); disabled
            { id = xi.item.SAKURAFUBUKI,      initial = 0,  maxStock = 30, targetStock = 25, buyMax = 127050,  restockRate = 0 },                -- targetStock assumed
            -- { id = xi.item.HOCHO,             initial = 0,  maxStock = 30, targetStock = 25, buyMax = 0,      restockRate = 0 }, -- unsourced (missing on Jirokichi too); disabled
            { id = xi.item.KABUTOWARI,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 322000,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.UCHIGATANA,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 26680,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.DOTANUKI,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 147957,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.KANESADA,          initial = 15, maxStock = 30, targetStock = 25, buyMax = 99000,   restockRate = 10 },
            { id = xi.item.ASHURA,            initial = 0,  maxStock = 30, targetStock = 25, buyMax = 227500,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.TACHI,             initial = 20, maxStock = 30, targetStock = 25, buyMax = 15704,   restockRate = 5 },
            { id = xi.item.NODACHI,           initial = 0,  maxStock = 30, targetStock = 25, buyMax = 40620,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.JINDACHI,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 722000,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.OKANEHIRA,         initial = 0,  maxStock = 30, targetStock = 25, buyMax = 104729,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.KOTETSU,           initial = 18, maxStock = 30, targetStock = 25, buyMax = 125440,  restockRate = 7 },
            { id = xi.item.HOMURA,            initial = 0,  maxStock = 30, targetStock = 25, buyMax = 207000,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.MIKAZUKI,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 317900,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.DAIHANNYA,         initial = 0,  maxStock = 30, targetStock = 25, buyMax = 816750,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.ODENTA,            initial = 0,  maxStock = 30, targetStock = 25, buyMax = 494000,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.HOSODACHI,         initial = 0,  maxStock = 30, targetStock = 25, buyMax = 259200,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.KIKU_ICHIMONJI,    initial = 0,  maxStock = 30, targetStock = 25, buyMax = 568700,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.ZANBATO,           initial = 0,  maxStock = 30, targetStock = 25, buyMax = 885500,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.KAZARIDACHI,       initial = 0,  maxStock = 30, targetStock = 25, buyMax = 1073250, restockRate = 0, hidden = true }, -- targetStock assumed
            { id = xi.item.KAMAYARI,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 549450,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.WYVERN_SPEAR,      initial = 0,  maxStock = 30, targetStock = 25, buyMax = 397800,  restockRate = 0, hidden = true }, -- targetStock assumed
            { id = xi.item.PIRATES_GUN,       initial = 0,  maxStock = 30, targetStock = 25, buyMax = 216000,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.TANEGASHIMA,       initial = 0,  maxStock = 30, targetStock = 25, buyMax = 65310,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.NEGOROSHIKI,       initial = 0,  maxStock = 30, targetStock = 25, buyMax = 660000,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.SHURIKEN,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 247,     restockRate = 0 },                -- targetStock assumed
            { id = xi.item.JUJI_SHURIKEN,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 448,     restockRate = 0 },                -- targetStock assumed
            { id = xi.item.MANJI_SHURIKEN,    initial = 0,  maxStock = 30, targetStock = 25, buyMax = 1890,    restockRate = 0 },                -- targetStock assumed
            { id = xi.item.FUMA_SHURIKEN,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 2000,    restockRate = 0 },                -- targetStock assumed
            { id = xi.item.PINWHEEL,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 1050,    restockRate = 0 },                -- targetStock assumed
            { id = xi.item.CHAKRAM,           initial = 0,  maxStock = 30, targetStock = 25, buyMax = 49979,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.MOONRING_BLADE,    initial = 0,  maxStock = 30, targetStock = 25, buyMax = 299250,  restockRate = 0 },                -- targetStock assumed
            { id = xi.item.QUAKE_GRENADE,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 18900,   restockRate = 0 },                -- targetStock assumed
            { id = xi.item.IRON_ARROW,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 40,      restockRate = 0 },                -- targetStock assumed
            { id = xi.item.FIRE_ARROW,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 700,     restockRate = 0 },                -- targetStock assumed
            { id = xi.item.BULLET,            initial = 0,  maxStock = 30, targetStock = 25, buyMax = 500,     restockRate = 0 },                -- targetStock assumed
            { id = xi.item.HACHIMAKI,         initial = 16, maxStock = 30, targetStock = 25, buyMax = 4125,    restockRate = 3 },
            { id = xi.item.COTTON_HACHIMAKI,  initial = 16, maxStock = 30, targetStock = 25, buyMax = 24420,   restockRate = 3 },
            { id = xi.item.SOIL_HACHIMAKI,    initial = 0,  maxStock = 30, targetStock = 25, buyMax = 66960,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHINOBI_HACHIGANE, initial = 0,  maxStock = 30, targetStock = 25, buyMax = 240460,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ZUNARI_KABUTO,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 180200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.NODOWA,            initial = 0,  maxStock = 30, targetStock = 25, buyMax = 149710,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DARKSTEEL_NODOWA,  initial = 0,  maxStock = 30, targetStock = 25, buyMax = 285000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KENPOGI,           initial = 16, maxStock = 30, targetStock = 25, buyMax = 6225,    restockRate = 3 },
            { id = xi.item.COTTON_DOGI,       initial = 16, maxStock = 30, targetStock = 25, buyMax = 36800,   restockRate = 3 },
            { id = xi.item.JUJITSU_GI,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 283500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SOIL_GI,           initial = 0,  maxStock = 30, targetStock = 25, buyMax = 99000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHINOBI_GI,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 363000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARA_ATE,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 330000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TEKKO,             initial = 16, maxStock = 30, targetStock = 25, buyMax = 3425,    restockRate = 3 },
            { id = xi.item.COTTON_TEKKO,      initial = 16, maxStock = 30, targetStock = 25, buyMax = 20250,   restockRate = 3 },
            { id = xi.item.SOIL_TEKKO,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 55440,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHINOBI_TEKKO,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 199650,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KOTE,              initial = 0,  maxStock = 30, targetStock = 25, buyMax = 181500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SITABAKI,          initial = 16, maxStock = 30, targetStock = 25, buyMax = 4975,    restockRate = 3 },
            { id = xi.item.COTTON_SITABAKI,   initial = 16, maxStock = 30, targetStock = 25, buyMax = 29490,   restockRate = 3 },
            { id = xi.item.SOIL_SITABAKI,     initial = 0,  maxStock = 30, targetStock = 25, buyMax = 80640,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHINOBI_HAKAMA,    initial = 0,  maxStock = 30, targetStock = 25, buyMax = 294525,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HAIDATE,           initial = 0,  maxStock = 30, targetStock = 25, buyMax = 217600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KYAHAN,            initial = 16, maxStock = 30, targetStock = 25, buyMax = 3175,    restockRate = 3 },
            { id = xi.item.COTTON_KYAHAN,     initial = 16, maxStock = 30, targetStock = 25, buyMax = 18870,   restockRate = 3 },
            { id = xi.item.SOIL_KYAHAN,       initial = 0,  maxStock = 30, targetStock = 25, buyMax = 82620,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HEKO_OBI,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 2475,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SILVER_OBI,        initial = 0,  maxStock = 30, targetStock = 25, buyMax = 18390,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GOLD_OBI,          initial = 0,  maxStock = 30, targetStock = 25, buyMax = 58880,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BROCADE_OBI,       initial = 0,  maxStock = 30, targetStock = 25, buyMax = 132000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAINBOW_OBI,       initial = 0,  maxStock = 30, targetStock = 25, buyMax = 268800,  restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Taten-Bilten'] =
    {
        hours   = { 6, 21 },
        holiday = xi.day.FIRESDAY,
        stock   =
        {
            { id = xi.item.SPOOL_OF_SILK_THREAD,    initial = 8,   maxStock = 30,  targetStock = 20,  buyMax = 4060,   restockRate = 1, priceFloor = 9 },
            { id = xi.item.SPOOL_OF_GRASS_THREAD,   initial = 180, maxStock = 240, targetStock = 180, buyMax = 300,    restockRate = 30 },
            { id = xi.item.SPOOL_OF_COTTON_THREAD,  initial = 132, maxStock = 240, targetStock = 180, buyMax = 800,    restockRate = 6 },
            { id = xi.item.SPOOL_OF_LINEN_THREAD,   initial = 102, maxStock = 180, targetStock = 135, buyMax = 5000,   restockRate = 6 },
            { id = xi.item.SPOOL_OF_RAINBOW_THREAD, initial = 0,   maxStock = 10,  targetStock = 7,   buyMax = 277200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPOOL_OF_SILVER_THREAD,  initial = 6,   maxStock = 30,  targetStock = 25,  buyMax = 5000,   restockRate = 1, priceFloor = 7.5 },
            { id = xi.item.SPOOL_OF_GOLD_THREAD,    initial = 5,   maxStock = 10,  targetStock = 7,   buyMax = 114000, restockRate = 1 },
            { id = xi.item.SQUARE_OF_GRASS_CLOTH,   initial = 36,  maxStock = 240, targetStock = 180, buyMax = 1600,   restockRate = 12 },
            { id = xi.item.SQUARE_OF_COTTON_CLOTH,  initial = 36,  maxStock = 240, targetStock = 180, buyMax = 3200,   restockRate = 12 },
            { id = xi.item.SQUARE_OF_LINEN_CLOTH,   initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 15000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_VELVET_CLOTH,  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 79750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_SILK_CLOTH,    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_RAINBOW_CLOTH, initial = 0,   maxStock = 240, targetStock = 180, buyMax = 567675, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CLUMP_OF_SHEEP_WOOL,     initial = 180, maxStock = 240, targetStock = 180, buyMax = 4500,   restockRate = 30 },
            { id = xi.item.CLUMP_OF_MOKO_GRASS,     initial = 180, maxStock = 240, targetStock = 180, buyMax = 100,    restockRate = 60 },
            { id = xi.item.BALL_OF_SARUTA_COTTON,   initial = 2,   maxStock = 240, targetStock = 97,  buyMax = 200,    restockRate = 1 },
            { id = xi.item.FLAX_FLOWER,             initial = 180, maxStock = 240, targetStock = 180, buyMax = 1250,   restockRate = 30 },
            { id = xi.item.SPIDER_WEB,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 33396,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PIECE_OF_CRAWLER_COCOON, initial = 60,  maxStock = 240, targetStock = 180, buyMax = 930,    restockRate = 10 },
            { id = xi.item.GIANT_BIRD_FEATHER,      initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4590,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPINDLE,                 initial = 180, maxStock = 240, targetStock = 180, buyMax = 500,    restockRate = 60 },
            { id = xi.item.SPOOL_OF_ZEPHYR_THREAD,  initial = 180, maxStock = 240, targetStock = 180, buyMax = 500,    restockRate = 60 },
            { id = xi.item.PUK_WING,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4590,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.APKALLU_FEATHER,         initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4590,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COLIBRI_FEATHER,         initial = 0,   maxStock = 240, targetStock = 180, buyMax = 4590,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAMOURA_COCOON,          initial = 66,  maxStock = 120, targetStock = 66,  buyMax = 780,    restockRate = 3 },
            { id = xi.item.SPOOL_OF_KARAKUL_THREAD, initial = 66,  maxStock = 120, targetStock = 90,  buyMax = 18000,  restockRate = 3 },
            { id = xi.item.SQUARE_OF_KARAKUL_CLOTH, initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 54900,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_WAMOURA_CLOTH, initial = 0,   maxStock = 240, targetStock = 180, buyMax = 114135, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HEADGEAR,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9800,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_HEADGEAR,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 44590,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RED_CAP,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 100000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_CAP,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 196350, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_HAT,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60690,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_HAT,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 128520, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_HEADBAND,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLAX_HEADBAND,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 80000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.DOUBLET,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13684,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_DOUBLET,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 68640,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GAMBISON,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 162500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_GAMBISON,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 343200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ROBE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1200,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_ROBE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 15425,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_ROBE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 90440,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_ROBE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 191520, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TUNIC,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_TUNIC,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51780,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CLOAK,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 166060, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GLOVES,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7575,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_GLOVES,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 37200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRACERS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 50400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_BRACERS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 189200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CUFFS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 660,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_CUFFS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8725,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_CUFFS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51170,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_CUFFS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 108360, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.MITTS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3275,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_MITTS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 78660,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_MITTS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 216750, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRAIS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10550,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_BRAIS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 54000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOSE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 122500, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_HOSE,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 288000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLOPS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 959,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_SLOPS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_SLOPS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 73780,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VELVET_SLOPS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 156240, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SLACKS,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4675,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_SLACKS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 34500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_SLACKS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 113160, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GAITERS,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7050,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_GAITERS,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 36050,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SOCKS,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 80000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WOOL_SOCKS,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 176000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FEATHER_COLLAR,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2075,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HEMP_GORGET,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5400,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WING_EARRING,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 48000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SCARLET_RIBBON,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6250,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLACK_CAPE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 55440,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CAPE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2125,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COTTON_CAPE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 15180,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RED_CAPE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 108900, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LINEN_DOUBLET,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 137940, restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Tilala'] =
    {
        hours   = { 6, 21 },
        holiday = xi.day.FIRESDAY,
        stock   =
        {
            { id = xi.item.BALL_OF_SARUTA_COTTON,   initial = 0,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLAX_FLOWER,             initial = 15, maxStock = 240, targetStock = 180, buyMax = 1250,   restockRate = 15 },
            { id = xi.item.CLUMP_OF_SHEEP_WOOL,     initial = 12, maxStock = 240, targetStock = 180, buyMax = 4500,   restockRate = 12 },
            { id = xi.item.PIECE_OF_CRAWLER_COCOON, initial = 0,  maxStock = 60,  targetStock = 45,  buyMax = 930,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPIDER_WEB,              initial = 0,  maxStock = 60,  targetStock = 45,  buyMax = 36300,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPOOL_OF_GRASS_THREAD,   initial = 30, maxStock = 240, targetStock = 180, buyMax = 300,    restockRate = 30 },
            { id = xi.item.SPOOL_OF_COTTON_THREAD,  initial = 15, maxStock = 240, targetStock = 180, buyMax = 800,    restockRate = 15 },
            { id = xi.item.SPOOL_OF_LINEN_THREAD,   initial = 9,  maxStock = 240, targetStock = 135, buyMax = 5000,   restockRate = 9, priceFloor = 135 },
            { id = xi.item.SPOOL_OF_WOOL_THREAD,    initial = 6,  maxStock = 240, targetStock = 90,  buyMax = 18000,  restockRate = 6, priceFloor = 90 },
            { id = xi.item.SPOOL_OF_SILK_THREAD,    initial = 4,  maxStock = 120, targetStock = 24,  buyMax = 4060,   restockRate = 4 },
            { id = xi.item.SPOOL_OF_SILVER_THREAD,  initial = 2,  maxStock = 120, targetStock = 110, buyMax = 5000,   restockRate = 2 },
            { id = xi.item.SPOOL_OF_GOLD_THREAD,    initial = 1,  maxStock = 120, targetStock = 110, buyMax = 114000, restockRate = 1 },
            { id = xi.item.SPOOL_OF_RAINBOW_THREAD, initial = 0,  maxStock = 120, targetStock = 90,  buyMax = 277200, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_GRASS_CLOTH,   initial = 12, maxStock = 240, targetStock = 180, buyMax = 1600,   restockRate = 12 },
            { id = xi.item.SQUARE_OF_COTTON_CLOTH,  initial = 12, maxStock = 240, targetStock = 180, buyMax = 3200,   restockRate = 12 },
            { id = xi.item.SQUARE_OF_LINEN_CLOTH,   initial = 0,  maxStock = 240, targetStock = 180, buyMax = 15000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_WOOL_CLOTH,    initial = 0,  maxStock = 240, targetStock = 180, buyMax = 54000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_VELVET_CLOTH,  initial = 0,  maxStock = 160, targetStock = 120, buyMax = 79750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_SILK_CLOTH,    initial = 0,  maxStock = 160, targetStock = 120, buyMax = 105000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SQUARE_OF_RAINBOW_CLOTH, initial = 0,  maxStock = 160, targetStock = 120, buyMax = 567675, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BIRD_FEATHER,            initial = 0,  maxStock = 240, targetStock = 180, buyMax = 40,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.YAGUDO_FEATHER,          initial = 0,  maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GIANT_BIRD_FEATHER,      initial = 0,  maxStock = 240, targetStock = 180, buyMax = 4590,   restockRate = 0 }, -- targetStock assumed
        },
    },
    ['Tsutsuroon'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.DARKSDAY,
        stock   =
        {
            { id = xi.item.KUNAI,                   initial = 50,  maxStock = 60,  targetStock = 55,  buyMax = 4420,    restockRate = 10 },
            { id = xi.item.SUZUME,                  initial = 50,  maxStock = 60,  targetStock = 55,  buyMax = 36120,   restockRate = 10 },
            { id = xi.item.HIEN,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 186000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KAGEBOSHI,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 215250,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAKIZASHI,               initial = 50,  maxStock = 60,  targetStock = 55,  buyMax = 12000,   restockRate = 10 },
            { id = xi.item.SHINOBI_GATANA,          initial = 50,  maxStock = 60,  targetStock = 55,  buyMax = 23321,   restockRate = 10 },
            { id = xi.item.KODACHI,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 67200,   restockRate = 0 }, -- targetStock assumed
            -- { id = xi.item.SHINOGI,                 initial = 0,  maxStock = 60,  targetStock = 45,  buyMax = 0,       restockRate = 0 }, -- unsourced (missing on Jirokichi too); disabled
            { id = xi.item.SAKURAFUBUKI,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 127050,  restockRate = 0 }, -- targetStock assumed
            -- { id = xi.item.HOCHO,                   initial = 0,  maxStock = 60,  targetStock = 45,  buyMax = 0,       restockRate = 0 }, -- unsourced (missing on Jirokichi too); disabled
            { id = xi.item.KABUTOWARI,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 322000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.UCHIGATANA,              initial = 50,  maxStock = 60,  targetStock = 55,  buyMax = 26680,   restockRate = 10 },
            { id = xi.item.DOTANUKI,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 715000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KANESADA,                initial = 30,  maxStock = 60,  targetStock = 55,  buyMax = 99000,   restockRate = 10 },
            { id = xi.item.ASHURA,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 227500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TACHI,                   initial = 50,  maxStock = 60,  targetStock = 55,  buyMax = 15695,   restockRate = 10 },
            { id = xi.item.NODACHI,                 initial = 20,  maxStock = 60,  targetStock = 55,  buyMax = 40620,   restockRate = 5 },
            { id = xi.item.JINDACHI,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 722000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.OKANEHIRA,               initial = 19,  maxStock = 60,  targetStock = 55,  buyMax = 104730,  restockRate = 7 },
            { id = xi.item.KOTETSU,                 initial = 19,  maxStock = 60,  targetStock = 55,  buyMax = 125440,  restockRate = 7 },
            { id = xi.item.HOMURA,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 207000,  restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.MIKAZUKI,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 317900,  restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.DAIHANNYA,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 816750,  restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.ODENTA,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 494000,  restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.HOSODACHI,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 259200,  restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.KIKU_ICHIMONJI,          initial = 10,  maxStock = 60,  targetStock = 10,  buyMax = 568700,  restockRate = 0 },
            { id = xi.item.ZANBATO,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 885500,  restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.KAZARIDACHI,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1073250, restockRate = 0,  hidden = true }, -- targetStock assumed
            { id = xi.item.KAMAYARI,                initial = 10,  maxStock = 60,  targetStock = 10,  buyMax = 549450,  restockRate = 0 },
            { id = xi.item.WYVERN_SPEAR,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 397800,  restockRate = 0,  hidden = true }, -- buyMax from Jirokichi; targetStock assumed
            { id = xi.item.PIRATES_GUN,             initial = 10,  maxStock = 60,  targetStock = 10,  buyMax = 216000,  restockRate = 0 },
            { id = xi.item.TANEGASHIMA,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 65310,   restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.NEGOROSHIKI,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 660000,  restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.SHURIKEN,                initial = 40,  maxStock = 60,  targetStock = 55,  buyMax = 250,     restockRate = 5 },
            { id = xi.item.JUJI_SHURIKEN,           initial = 30,  maxStock = 60,  targetStock = 55,  buyMax = 450,     restockRate = 5 },
            { id = xi.item.MANJI_SHURIKEN,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1890,    restockRate = 0,  hidden = true }, -- targetStock assumed
            { id = xi.item.FUMA_SHURIKEN,           initial = 10,  maxStock = 60,  targetStock = 10,  buyMax = 2000,    restockRate = 0 },
            { id = xi.item.PINWHEEL,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1050,    restockRate = 0,  hidden = true }, -- targetStock assumed
            { id = xi.item.CHAKRAM,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 49980,   restockRate = 0,  hidden = true }, -- targetStock assumed
            { id = xi.item.MOONRING_BLADE,          initial = 10,  maxStock = 60,  targetStock = 10,  buyMax = 299250,  restockRate = 0 },
            { id = xi.item.QUAKE_GRENADE,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18900,   restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.IRON_ARROW,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 40,      restockRate = 0 },                 -- targetStock assumed
            { id = xi.item.FIRE_ARROW,              initial = 40,  maxStock = 60,  targetStock = 55,  buyMax = 700,     restockRate = 5 },
            { id = xi.item.BULLET,                  initial = 30,  maxStock = 60,  targetStock = 55,  buyMax = 500,     restockRate = 5 },
            { id = xi.item.HACHIMAKI,               initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 4125,    restockRate = 3 },
            { id = xi.item.COTTON_HACHIMAKI,        initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 24420,   restockRate = 3 },
            { id = xi.item.SOIL_HACHIMAKI,          initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 66960,   restockRate = 3 },
            { id = xi.item.SHINOBI_HACHIGANE,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 240460,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ZUNARI_KABUTO,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 180200,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.NODOWA,                  initial = 30,  maxStock = 60,  targetStock = 30,  buyMax = 149710,  restockRate = 0 },
            { id = xi.item.DARKSTEEL_NODOWA,        initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 285000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KENPOGI,                 initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 6225,    restockRate = 3 },
            { id = xi.item.COTTON_DOGI,             initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 36800,   restockRate = 3 },
            { id = xi.item.JUJITSU_GI,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 283500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SOIL_GI,                 initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 99000,   restockRate = 3 },
            { id = xi.item.SHINOBI_GI,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 363000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HARA_ATE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 330000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TEKKO,                   initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 3425,    restockRate = 3 },
            { id = xi.item.COTTON_TEKKO,            initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 20250,   restockRate = 3 },
            { id = xi.item.SOIL_TEKKO,              initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 55440,   restockRate = 3 },
            { id = xi.item.SHINOBI_TEKKO,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 199650,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KOTE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 181500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SITABAKI,                initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 4973,    restockRate = 3 },
            { id = xi.item.COTTON_SITABAKI,         initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 29490,   restockRate = 3 },
            { id = xi.item.SOIL_SITABAKI,           initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 80640,   restockRate = 3 },
            { id = xi.item.SHINOBI_HAKAMA,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 294525,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HAIDATE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 217600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KYAHAN,                  initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 3173,    restockRate = 3 },
            { id = xi.item.COTTON_KYAHAN,           initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 18870,   restockRate = 3 },
            { id = xi.item.SOIL_KYAHAN,             initial = 36,  maxStock = 60,  targetStock = 45,  buyMax = 82620,   restockRate = 3 },
            { id = xi.item.HEKO_OBI,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2475,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SILVER_OBI,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 18390,   restockRate = 0 }, -- buyMax from Achika; targetStock assumed
            { id = xi.item.GOLD_OBI,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 58880,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BROCADE_OBI,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 132000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RAINBOW_OBI,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 268800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BAMBOO_STICK,            initial = 50,  maxStock = 240, targetStock = 180, buyMax = 720,     restockRate = 10 },
            { id = xi.item.JAR_OF_TOAD_OIL,         initial = 18,  maxStock = 60,  targetStock = 45,  buyMax = 18000,   restockRate = 4 },
            { id = xi.item.SHEET_OF_BAST_PARCHMENT, initial = 10,  maxStock = 60,  targetStock = 45,  buyMax = 5400,    restockRate = 2 },
            { id = xi.item.SQUARE_OF_SILK_CLOTH,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 105000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HANDFUL_OF_IRON_SAND,    initial = 190, maxStock = 240, targetStock = 190, buyMax = 2370,    restockRate = 60, priceFloor = 270 },
            { id = xi.item.LUMP_OF_TAMA_HAGANE,     initial = 80,  maxStock = 120, targetStock = 100, buyMax = 35000,   restockRate = 10 },
            { id = xi.item.POT_OF_URUSHI,           initial = 14,  maxStock = 60,  targetStock = 45,  buyMax = 367650,  restockRate = 2 },
            { id = xi.item.UCHITAKE,                initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,     restockRate = 10 },
            { id = xi.item.TSURARA,                 initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,     restockRate = 10 },
            { id = xi.item.KAWAHORI_OGI,            initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,     restockRate = 10 },
            { id = xi.item.MAKIBISHI,               initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,     restockRate = 10 },
            { id = xi.item.HIRAISHIN,               initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,     restockRate = 10 },
            { id = xi.item.MIZU_DEPPO,              initial = 80,  maxStock = 240, targetStock = 180, buyMax = 200,     restockRate = 10 },
            { id = xi.item.SHIHEI,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 625,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.JUSATSU,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 625,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KAGINAWA,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 625,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SAIRUI_RAN,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 625,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.KODOKU,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 625,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SHINOBI_TABI,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 625,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GARDENIA_SEED,           initial = 150, maxStock = 200, targetStock = 150, buyMax = 2460,    restockRate = 50 },
            { id = xi.item.ONZ_OF_TURMERIC,         initial = 170, maxStock = 240, targetStock = 170, buyMax = 3225,    restockRate = 80 },
            { id = xi.item.ONZ_OF_CORIANDER,        initial = 170, maxStock = 240, targetStock = 170, buyMax = 7924,    restockRate = 80 },
            { id = xi.item.SPRIG_OF_HOLY_BASIL,     initial = 170, maxStock = 240, targetStock = 170, buyMax = 4000,    restockRate = 80 },
            { id = xi.item.ONZ_OF_CURRY_POWDER,     initial = 110, maxStock = 120, targetStock = 110, buyMax = 4950,    restockRate = 50 },
            { id = xi.item.JAR_OF_GROUND_WASABI,    initial = 150, maxStock = 200, targetStock = 150, buyMax = 12967,   restockRate = 100 },
            { id = xi.item.BOTTLE_OF_RICE_VINEGAR,  initial = 150, maxStock = 200, targetStock = 150, buyMax = 1000,    restockRate = 100 },
            { id = xi.item.HEAD_OF_NAPA,            initial = 150, maxStock = 200, targetStock = 150, buyMax = 1250,    restockRate = 100 },
        },
    },
    ['Visala'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.ICEDAY,
        stock   =
        {
            { id = xi.item.CHUNK_OF_SILVER_ORE,     initial = 180, maxStock = 240, targetStock = 180, buyMax = 2100,   restockRate = 60 }, -- targetStock assumed
            { id = xi.item.CHUNK_OF_MYTHRIL_ORE,    initial = 12,  maxStock = 120, targetStock = 90,  buyMax = 10000,  restockRate = 6 },  -- targetStock assumed
            { id = xi.item.CHUNK_OF_GOLD_ORE,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 23100,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHUNK_OF_PLATINUM_ORE,   initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 58500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_INGOT,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 600,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_INGOT,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_INGOT,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 10500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_INGOT,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 50000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_INGOT,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 115500, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_INGOT,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 292500, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_SHEET,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1200,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_SHEET,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_SHEET,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 371700, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_SHEET,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 581250, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.HANDFUL_OF_BRASS_SCALES, initial = 3,   maxStock = 121, targetStock = 91,  buyMax = 1400,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.SILVER_CHAIN,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 78000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_CHAIN,           initial = 3,   maxStock = 121, targetStock = 91,  buyMax = 70000,  restockRate = 1 },  -- targetStock assumed
            { id = xi.item.GOLD_CHAIN,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 255240, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_CHAIN,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 418500, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.RED_ROCK,                initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.BLUE_ROCK,               initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.YELLOW_ROCK,             initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.GREEN_ROCK,              initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.TRANSLUCENT_ROCK,        initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.PURPLE_ROCK,             initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.BLACK_ROCK,              initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.WHITE_ROCK,              initial = 4,   maxStock = 240, targetStock = 15,  buyMax = 7000,   restockRate = 1 },  -- targetStock assumed
            { id = xi.item.LAPIS_LAZULI,            initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.LIGHT_OPAL,              initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.ONYX,                    initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.AMETHYST,                initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.TOURMALINE,              initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.SARDONYX,                initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.CLEAR_TOPAZ,             initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.AMBER_STONE,             initial = 18,  maxStock = 120, targetStock = 90,  buyMax = 9315,   restockRate = 6 },  -- targetStock assumed
            { id = xi.item.PERIDOT,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GARNET,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETRINE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SPHENE,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TURQUOISE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOSHENITE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 60000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.JADEITE,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SUNSTONE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.FLUORITE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHRYSOBERYL,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AQUAMARINE,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZIRCON,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PAINITE,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MOONSTONE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 156000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.EMERALD,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.RUBY,                    initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SPINEL,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TOPAZ,                   initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SAPPHIRE,                initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DIAMOND,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DEATHSTONE,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ANGELSTONE,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 304000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_EARRING,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_EARRING,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 22500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_EARRING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 87500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 399000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PEARL_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PERIDOT_EARRING,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TOURMALINE_EARRING,      initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SARDONYX_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLEAR_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETHYST_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAPIS_LAZULI_EARRING,    initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMBER_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ONYX_EARRING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OPAL_EARRING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3225,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLOOD_EARRING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOSHENITE_EARRING,       initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETRINE_EARRING,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TURQUOISE_EARRING,       initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SPHENE_EARRING,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_RING,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 380,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_RING,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 1000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_RING,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MYTHRIL_RING,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 22500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_RING,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 87500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PLATINUM_RING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 434000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OPAL_RING,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SARDONYX_RING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TOURMALINE_RING,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLEAR_RING,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMETHYST_RING,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAPIS_LAZULI_RING,       initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AMBER_RING,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ONYX_RING,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6250,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_BANGLES,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 133920, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_BANGLES,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 232200, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_HAIRPIN,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 780,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_HAIRPIN,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6475,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_HAIRPIN,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 29325,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_KNUCKLES,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 4500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_BAGHNAKHS,         initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 8450,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_DAGGER,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 4650,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SAPARA,                  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3880,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_XIPHOS,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 19575,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_AXE,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 7800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_ZAGHNAL,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_ROD,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 3450,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_HAMMER,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 11570,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CIRCLET,                 initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 800,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.POETS_CIRCLET,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 10350,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_CAP,               initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 8175,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_MASK,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 64000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_MASK,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 114000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_HARNESS,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 12425,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_SCALE_MAIL,        initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 97440,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_MITTENS,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6825,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_MITTENS,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 94000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_FINGER_GAUNTLETS,  initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 51840,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_SUBLIGAR,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 10000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_LEGGINGS,          initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 6200,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_CUISSES,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 77280,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BRASS_GREAVES,           initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 45760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_BELT,             initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 57120,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHAIN_BELT,              initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 30600,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHAIN_CHOKER,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 24300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CHAIN_GORGET,            initial = 0,   maxStock = 24,  targetStock = 18,  buyMax = 30600,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SLAB_OF_TUFA,            initial = 180, maxStock = 240, targetStock = 180, buyMax = 136000, restockRate = 60 }, -- targetStock assumed
        },
    },
    ['Vuliaie'] =
    {
        hours   = { 9, 23 },
        holiday = xi.day.DARKSDAY,
        stock   =
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
    ['Wahnid'] = -- TODO: Recapture initial
    {
        hours   = { 1, 18 },
        holiday = xi.day.LIGHTSDAY,
        stock   =
        {
            { id = xi.item.LITTLE_WORM,             initial = 180, maxStock = 240, targetStock = 180, buyMax = 20,     restockRate = 60 }, -- targetStock assumed
            { id = xi.item.LUGWORM,                 initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,     restockRate = 60 }, -- targetStock assumed
            { id = xi.item.BALL_OF_SARDINE_PASTE,   initial = 156, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.BALL_OF_CRAYFISH_PASTE,  initial = 156, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.BALL_OF_INSECT_PASTE,    initial = 156, maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.BALL_OF_TROUT_PASTE,     initial = 156, maxStock = 240, targetStock = 180, buyMax = 348,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.MEATBALL,                initial = 156, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_SARDINE,        initial = 156, maxStock = 240, targetStock = 180, buyMax = 1425,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_COD,            initial = 57,  maxStock = 240, targetStock = 180, buyMax = 1425,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.PEELED_LOBSTER,          initial = 156, maxStock = 240, targetStock = 180, buyMax = 1470,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_BLUETAIL,       initial = 156, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.PEELED_CRAYFISH,         initial = 156, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.SLICE_OF_MOAT_CARP,      initial = 156, maxStock = 240, targetStock = 180, buyMax = 350,    restockRate = 12 }, -- targetStock assumed
            { id = xi.item.FLY_LURE,                initial = 156, maxStock = 240, targetStock = 180, buyMax = 3600,   restockRate = 12 }, -- targetStock assumed
            { id = xi.item.MINNOW,                  initial = 156, maxStock = 240, targetStock = 180, buyMax = 2025,   restockRate = 5 },  -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5160,   restockRate = 3 },  -- targetStock assumed
            { id = xi.item.WORM_LURE,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 3600,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.FROG_LURE,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHRIMP_LURE,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5730,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LIZARD_LURE,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 4590,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SABIKI_RIG,              initial = 156, maxStock = 240, targetStock = 180, buyMax = 15960,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.WILLOW_FISHING_ROD,      initial = 0,   maxStock = 180, targetStock = 135, buyMax = 360,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YEW_FISHING_ROD,         initial = 117, maxStock = 180, targetStock = 160, buyMax = 1180,   restockRate = 9 },  -- targetStock assumed
            { id = xi.item.BAMBOO_FISHING_ROD,      initial = 0,   maxStock = 180, targetStock = 160, buyMax = 2700,   restockRate = 9 },
            { id = xi.item.FASTWATER_FISHING_ROD,   initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 6975,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD,    initial = 39,  maxStock = 60,  targetStock = 45,  buyMax = 27180,  restockRate = 10 }, -- targetStock assumed
            { id = xi.item.MITHRAN_FISHING_ROD,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 171600, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GLASS_FIBER_FISHING_ROD, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 43140,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLOTHESPOLE,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 13200,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SINGLE_HOOK_FISHING_ROD, initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 64380,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DENIZANASI,              initial = 0,   maxStock = 240, targetStock = 180, buyMax = 170,    restockRate = 12 },
            { id = xi.item.CRAYFISH_1,              initial = 24,  maxStock = 120, targetStock = 90,  buyMax = 200,    restockRate = 6 },  -- targetStock assumed
            { id = xi.item.GURNARD,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 28500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MOAT_CARP_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 200,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.FOREST_CARP,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 300,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.HAMSI,                   initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 140,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ALABALIGI,               initial = 0,   maxStock = 120, targetStock = 2,   buyMax = 650,    restockRate = 0 },
            { id = xi.item.ISTIRIDYE,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.RHINOCHIMERA_1,          initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 18000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TRICOLORED_CARP,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1300,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SAZANBALIGI,             initial = 0,   maxStock = 120, targetStock = 4,   buyMax = 9000,   restockRate = 0 },
            { id = xi.item.ISTAVRIT_1,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 4000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PIPIRA_1,                initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1150,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1300,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DARK_BASS_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 1300,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.AHTAPOT,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YILANBALIGI,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 6000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 800,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZEBRA_EEL,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ICEFISH,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 4590,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SANDFISH,                initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 650,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.PTERYGOTUS,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 78000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KAPLUMBAGA,              initial = 0,   maxStock = 120, targetStock = 2,   buyMax = 9000,   restockRate = 0 },
            { id = xi.item.ISTAKOZ,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 6000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.USKUMRU,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 6000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CRESCENT_FISH,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 15400,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.COPPER_FROG_1,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CAEDARVA_FROG,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KALKANBALIGI,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 78000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 20000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MERCANBALIGI,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.DIL,                     initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 160,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,                  initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 400,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CORAL_BUTTERFLY,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YAYINBALIGI,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TURNABALIGI,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 61200,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MONKE_ONKE_1,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GAVIAL_FISH,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 20000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAKERDA,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2575,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KILICBALIGI,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 9000,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KALAMAR,                 initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 8500,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MOLA_MOLA,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 97500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KAYABALIGI,              initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 23250,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BETTA,                   initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAMP_MARIMO,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 620,    restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_GHOST,             initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.MORINABALIGI,            initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.VEYDAL_WRASSE_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 13500,  restockRate = 0 },  -- targetStock assumed
        },
    },
    ['Wahraga'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.JAR_OF_BLACK_INK,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3800,   restockRate = 0 }, -- buyMax from Maymunah; targetStock assumed
            { id = xi.item.FLASK_OF_DEODORIZER,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4800,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POTION,                      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4550,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HI_POTION,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ETHER,                       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24160,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PINCH_OF_PRISM_POWDER,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ARTIFICIAL_LENS,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6200,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.IMP_WING,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 320,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PEPHREDO_HIVE_CHIP,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 320,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COLIBRI_BEAK,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6250,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.CHUNK_OF_FLAN_MEAT,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 700,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VIAL_OF_CHIMERA_BLOOD,       initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 7200,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WAX_SWORD,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1340,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEE_SPATHA,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 17625,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SILENCE_DAGGER,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 10150,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SILENCE_BAGHNAKHS,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24750,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLAME_CLAYMORE,              initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 24475,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLIND_DAGGER,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BLIND_KNIFE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 3375,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_BASELARD,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 33000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_KNIFE,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 36780,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_DAGGER,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 28770,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_KUKRI,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 48600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_CESTI,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 34720,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_BAGHNAKHS,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 82940,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_CLAWS,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 96000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POISON_KATARS,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 110880, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FIRE_SWORD,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 39600,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLAME_BLADE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 426250, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLAME_DEGEN,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 216000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BEEHIVE_CHIP,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 200,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LUMP_OF_BEESWAX,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 600,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.VIAL_OF_MERCURY,             initial = 10,  maxStock = 60,  targetStock = 45,  buyMax = 7500,   restockRate = 1 },
            { id = xi.item.MALBORO_VINE,                initial = 10,  maxStock = 60,  targetStock = 45,  buyMax = 7230,   restockRate = 1 },
            { id = xi.item.BAT_WING,                    initial = 0,   maxStock = 240, targetStock = 180, buyMax = 300,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GIANT_STINGER,               initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 4050,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PINCH_OF_BOMB_ASH,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2575,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PINCH_OF_SULFUR,             initial = 52,  maxStock = 120, targetStock = 90,  buyMax = 3825,   restockRate = 6 },
            { id = xi.item.BLOCK_OF_ANIMAL_GLUE,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 600,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.WIJNRUIT,                    initial = 68,  maxStock = 240, targetStock = 180, buyMax = 600,    restockRate = 4 },
            { id = xi.item.POT_OF_CRYING_MUSTARD,       initial = 68,  maxStock = 240, targetStock = 180, buyMax = 140,    restockRate = 4 },
            { id = xi.item.PINCH_OF_DRIED_MARJORAM,     initial = 68,  maxStock = 240, targetStock = 180, buyMax = 240,    restockRate = 4 },
            { id = xi.item.CHAMOMILE,                   initial = 68,  maxStock = 240, targetStock = 180, buyMax = 650,    restockRate = 4 },
            { id = xi.item.VIAL_OF_SLIME_OIL,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 5000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.POT_OF_SILENT_OIL,           initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SPRIG_OF_SAGE,               initial = 144, maxStock = 240, targetStock = 180, buyMax = 925,    restockRate = 12 },
            { id = xi.item.CERMET_CHUNK,                initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 20000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,            initial = 24,  maxStock = 240, targetStock = 180, buyMax = 160,    restockRate = 6 },
            { id = xi.item.LOOP_OF_GLASS_FIBER,         initial = 42,  maxStock = 240, targetStock = 180, buyMax = 4000,   restockRate = 6 },
            { id = xi.item.LOOP_OF_CARBON_FIBER,        initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 6000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLASK_OF_DISTILLED_WATER,    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 60,     restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLASK_OF_HOLY_WATER,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 14500,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.PINCH_OF_POISON_DUST,        initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1600,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLASK_OF_POISON_POTION,      initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2500,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ANTIDOTE,                    initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 1580,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLASK_OF_EYE_DROPS,          initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 12255,  restockRate = 0 }, -- buyMax from Maymunah; targetStock assumed
            { id = xi.item.FLASK_OF_SILENCING_POTION,   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4500,   restockRate = 0 }, -- buyMax from Maymunah; targetStock assumed
            { id = xi.item.FLASK_OF_ECHO_DROPS,         initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 4000,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.JAR_OF_FIRESAND,             initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 22400,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FLASH_OF_VITRIOL,            initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 2400,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.INFERNO_AXE,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 8725,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.INFERNO_SWORD,               initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 122080, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ACID_DAGGER,                 initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 51510,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ACID_KNIFE,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 86800,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ACID_CLAWS,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 148800, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLY_SWORD,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 172000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLY_DEGEN,                  initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 280000, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.HOLY_MACE,                   initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 155100, restockRate = 0 }, -- targetStock assumed
            { id = xi.item.FIRE_ARROW,                  initial = 0,   maxStock = 240, targetStock = 180, buyMax = 700,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.ICE_ARROW,                   initial = 0,   maxStock = 240, targetStock = 180, buyMax = 700,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.LIGHTNING_ARROW,             initial = 0,   maxStock = 240, targetStock = 180, buyMax = 700,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BRONZE_BULLET,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 135,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.BULLET,                      initial = 0,   maxStock = 240, targetStock = 180, buyMax = 500,    restockRate = 0 }, -- targetStock assumed
            { id = xi.item.SILVER_BULLET,               initial = 0,   maxStock = 240, targetStock = 180, buyMax = 2480,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.GRENADE,                     initial = 0,   maxStock = 240, targetStock = 180, buyMax = 6020,   restockRate = 0 }, -- targetStock assumed
            { id = xi.item.RIOT_GRENADE,                initial = 0,   maxStock = 240, targetStock = 180, buyMax = 30000,  restockRate = 0 }, -- targetStock assumed
            { id = xi.item.TRITURATOR,                  initial = 180, maxStock = 240, targetStock = 180, buyMax = 500,    restockRate = 60 },
            { id = xi.item.BUNDLE_OF_HOMUNCULUS_NERVES, initial = 180, maxStock = 240, targetStock = 180, buyMax = 6425,   restockRate = 60 },
            { id = xi.item.SHEET_OF_POLYFLAN_PAPER,     initial = 180, maxStock = 240, targetStock = 180, buyMax = 40,     restockRate = 60 },
            { id = xi.item.BATTERY,                     initial = 180, maxStock = 240, targetStock = 180, buyMax = 760,    restockRate = 60 },
            { id = xi.item.HYDRO_PUMP,                  initial = 180, maxStock = 240, targetStock = 180, buyMax = 760,    restockRate = 60 },
            { id = xi.item.WIND_FAN,                    initial = 180, maxStock = 240, targetStock = 180, buyMax = 140,    restockRate = 60 },
            { id = xi.item.PINCH_OF_MINIUM,             initial = 24,  maxStock = 240, targetStock = 180, buyMax = 453750, restockRate = 6 },
        },
    },
    ['Yabby_Tanmikey'] =
    {
        hours   = { 8, 23 },
        holiday = xi.day.ICEDAY,
        stock   =
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
    ['Yahliq'] =
    {
        hours   = { 1, 23 },
        holiday = xi.day.LIGHTNINGDAY,
        stock   =
        {
            { id = xi.item.LUGWORM,              initial = 180, maxStock = 240, targetStock = 180, buyMax = 60,    restockRate = 60 }, -- targetStock assumed
            { id = xi.item.SABIKI_RIG,           initial = 20,  maxStock = 120, targetStock = 90,  buyMax = 15960, restockRate = 5 },  -- targetStock assumed
            { id = xi.item.MINNOW,               initial = 20,  maxStock = 60,  targetStock = 50,  buyMax = 2025,  restockRate = 5 },  -- targetStock assumed
            { id = xi.item.SINKING_MINNOW,       initial = 16,  maxStock = 60,  targetStock = 50,  buyMax = 5160,  restockRate = 3 },  -- targetStock assumed
            { id = xi.item.TARUTARU_FISHING_ROD, initial = 140, maxStock = 240, targetStock = 180, buyMax = 27180, restockRate = 10 }, -- targetStock assumed
            { id = xi.item.COBALT_JELLYFISH,     initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.CLUMP_OF_PAMTAM_KELP, initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_SARDINE_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SHALL_SHELL,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.YELLOW_GLOBE,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOSTEAU_HERRING_1,    initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.TIGER_COD_1,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NEBIMONITE,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 1300,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.OGRE_EEL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 800,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ZAFMLUG_BASS,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 775,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GOLD_LOBSTER_1,       initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 5760,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLUETAIL_1,           initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.NOBLE_LADY,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.SILVER_SHARK,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 20000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BASTORE_BREAM,        initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 27000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLACK_SOLE,           initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 35000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GREEDIE,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 160,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.QUUS_1,               initial = 0,   maxStock = 200, targetStock = 150, buyMax = 400,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.GUGRU_TUNA_1,         initial = 0,   maxStock = 120, targetStock = 90,  buyMax = 2500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BHEFHEL_MARLIN_1,     initial = 0,   maxStock = 60,  targetStock = 45,  buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.BLADEFISH_1,          initial = 0,   maxStock = 40,  targetStock = 30,  buyMax = 14000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KALKANBALIGI,         initial = 0,   maxStock = 200, targetStock = 150, buyMax = 78000, restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KALAMAR,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 8500,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.HAMSI,                initial = 0,   maxStock = 200, targetStock = 150, buyMax = 140,   restockRate = 0 },  -- targetStock assumed
            { id = xi.item.LAKERDA,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 2575,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.KILICBALIGI,          initial = 0,   maxStock = 200, targetStock = 150, buyMax = 9000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.USKUMRU,              initial = 0,   maxStock = 200, targetStock = 150, buyMax = 6000,  restockRate = 0 },  -- targetStock assumed
            { id = xi.item.ICE_CARD,             initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
            { id = xi.item.THUNDER_CARD,         initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
            { id = xi.item.LIGHT_CARD,           initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
            { id = xi.item.DARK_CARD,            initial = 140, maxStock = 240, targetStock = 180, buyMax = 240,   restockRate = 10 }, -- targetStock assumed
        },
    },
}
