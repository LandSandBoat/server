-----------------------------------
---- ZNM Data Tables
---- Sanraku Trophies, Pop Items, Seals, etc.
-----------------------------------

xi = xi or {}
xi.znm = xi.znm or {}

-----------------------------------
---- Soultrapper Variables
-----------------------------------
xi.znm.SOULTRAPPER_SUCCESS = 60     -- Base success rate
xi.znm.SOULTRAPPER_HPPMULT = 2.5    -- Zeni multiplier for low hp %
xi.znm.INTEREST_MULT = 2     -- Sanraku recommended interest multiplier
xi.znm.FAUNA_MULT    = 2     -- Sanraku rare fauna multiplier

-----------------------------------
---- Zeni Prices
-----------------------------------
local ZNM_POP_COSTS = {
    [1] = {minPrice = 1000, maxPrice = 2500, addedPrice = 100, decayPrice = 100},
    [2] = {minPrice = 2000, maxPrice = 5000, addedPrice = 200, decayPrice = 200},
    [3] = {minPrice = 3000, maxPrice = 7500, addedPrice = 300, decayPrice = 300},
    [4] = {minPrice = 4000, maxPrice = 9000, addedPrice = 400, decayPrice = 400},
    [5] = {minPrice = 5000, maxPrice = 12000, addedPrice = 500, decayPrice = 500}
}

--xi.znm.updatePopPrice = function(znm_tier)
--    local price = math.min(GetServerVariable("[ZNM][T" .. znm_tier .. "]Cost") + ZNM_POP_COSTS[znm_tier].addedPrice,
--                              ZNM_POP_COSTS[znm_tier].maxPrice)
--    SetServerVariable("[ZNM][T" .. znm_tier .. "]Cost", price )
--end
--
--xi.znm.getPopPrice = function(znm_tier)
--    return GetServerVariable("[ZNM][T" .. znm_tier .. "]Cost")
--end

--function PopPriceDecay() -- Prices drop every 2 hours
--    local price = 0
--    for tier = 1,5 do
--        price = math.min(GetServerVariable("[ZNM][T" .. tier .. "]Cost")- ZNM_POP_COSTS[znm_tier].decayPrice,
--                                  - ZNM_POP_COSTS[znm_tier].minPrice)
--        SetServerVariable("[ZNM][T" .. tier .. "]Cost", price)
--    end
--end

-----------------------------------
---- Sanraku's Interest and Recommended Fauna
-----------------------------------

--function UpdateSanrakusInterest()
--    SetServerVariable('[ZNM][Sanraku]Interest', math.random(0,61))
--    SetServerVariable('[ZNM][Sanraku]Fauna', math.random(0,54))
--end
--
---- Get Sanraku's "Subject of Interest"
--xi.znm.getSanrakusInterest = function()
--    return GetServerVariable('[ZNM][Sanraku]Interest')
--end
--
---- Get Sanraku's "Recommended Fauna"
--xi.znm.getSanrakusFauna = function()
--    return GetServerVariable('[ZNM][Sanraku]Fauna')
--end

------------------------------------------------------------
---- Sanraku's Trophy Trades and Pop Items
------------------------------------------------------------
xi.znm.trophies = { -- [mob_trophy] = seal_rewarded
    [xi.items.VULPANGUES_WING]          = xi.keyItem.MAROON_SEAL,
    [xi.items.CHAMROSHS_BEAK]           = xi.keyItem.MAROON_SEAL,
    [xi.items.GIGIROONS_CAPE]           = xi.keyItem.MAROON_SEAL,
    [xi.items.BRASS_BORERS_COCOON]      = xi.keyItem.CERISE_SEAL,
    [xi.items.GLOBULE_OF_CLARET]        = xi.keyItem.CERISE_SEAL,
    [xi.items.OBS_ARM]                  = xi.keyItem.CERISE_SEAL,
    [xi.items.VELIONIS_BONE]            = xi.keyItem.PINE_GREEN_SEAL,
    [xi.items.LIL_APKALLUS_EGG]         = xi.keyItem.PINE_GREEN_SEAL,
    [xi.items.CHIGRE]                   = xi.keyItem.PINE_GREEN_SEAL,
    [xi.items.IRIZ_IMAS_HIDE]           = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.items.AMOOSHAHS_TENDRIL]        = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.items.IRIRI_SAMARIRIS_HAT]      = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.items.ANANTABOGAS_HEART]        = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.items.PILE_OF_REACTONS_ASHES]   = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.items.BLOB_OF_DEXTROSE_BLUBBER] = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.items.ZAREEHKLS_NECKPIECE]      = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.items.VERDELETS_WING]           = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.items.WULGARUS_HEAD]            = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.items.ARMED_GEARS_FRAGMENT]     = xi.keyItem.CHARCOAL_GREY_SEAL,
    [xi.items.GOTOH_ZHAS_NECKLACE]      = xi.keyItem.DEEP_PURPLE_SEAL,
    [xi.items.DEAS_HORN]                = xi.keyItem.CHESTNUT_COLORED_SEAL,
    [xi.items.NOSFERATUS_CLAW]          = xi.keyItem.PURPLISH_GREY_SEAL,
    [xi.items.BHURBORLORS_VAMBRACE]     = xi.keyItem.GOLD_COLORED_SEAL,
    [xi.items.ACHAMOTHS_ANTENNA]        = xi.keyItem.COPPER_COLORED_SEAL,
    [xi.items.MAHJLAEFS_STAFF]          = xi.keyItem.FALLOW_COLORED_SEAL,
    [xi.items.EXPERIMENTAL_LAMIAS_ARMBAND] = xi.keyItem.TAUPE_COLORED_SEAL,
    [xi.items.NUHNS_ESCA]               = xi.keyItem.SIENNA_COLORED_SEAL,
    [xi.items.TINNINS_FANG]             = xi.keyItem.LILAC_COLORED_SEAL,
    [xi.items.SARAMEYAS_HIDE]           = xi.keyItem.BRIGHT_BLUE_SEAL,
    [xi.items.TYGERS_TAIL]              = xi.keyItem.LAVENDER_COLORED_SEAL
}

xi.znm.pop_items = {
    -- Ordered to match the csid options
    -- { popitemID, ZNMtier (for zeni price updating), seals_to_remove}
    {item = xi.items.HELLCAGE_BUTTERFLY,            tier = 1, seal = 0},                             -- Vulpangue
    {item = xi.items.JUG_OF_FLORAL_NECTAR,          tier = 1, seal = 0},                             -- Chamrosh
    {item = xi.items.WEDGE_OF_RODENT_CHEESE,        tier = 1, seal = 0},                             -- Cheese Hoarder Gigiroon
    {item = xi.items.BUNCH_OF_SENORITA_PAMAMAS,     tier = 2, seal = xi.keyItem.MAROON_SEAL},        -- Iriz Ima
    {item = xi.items.JAR_OF_OILY_BLOOD,             tier = 2, seal = xi.keyItem.MAROON_SEAL},        -- Lividroot Amooshah
    {item = xi.items.STRAND_OF_SAMARIRI_CORPSEHAIR, tier = 2, seal = xi.keyItem.MAROON_SEAL},        -- Iriri Samariri
    {item = xi.items.BAR_OF_FERRITE,                tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL},   -- Armed Gear
    {item = xi.items.BAGGED_SHEEP_BOTFLY,           tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL},   -- Gotoh Zha the Redolent
    {item = xi.items.OLZHIRYAN_CACTUS_PADDLE,       tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL},   -- Dea
    {item = xi.items.JUG_OF_MONKEY_WINE,            tier = 4, seal = {xi.keyItem.CHARCOAL_GREY_SEAL, -- Tinnin
                                                                 xi.keyItem.DEEP_PURPLE_SEAL,
                                                                 xi.keyItem.CHESTNUT_COLORED_SEAL}},
    {item = xi.items.CLUMP_OF_SHADELEAVES,          tier = 1, seal = 0},                             -- Brass Borer
    {item = xi.items.BEAKER_OF_PECTIN,              tier = 1, seal = 0},                             -- Claret
    {item = xi.items.FLASK_OF_COG_LUBRICANT,        tier = 1, seal = 0},                             -- Ob
    {item = xi.items.SLAB_OF_RAW_BUFFALO,           tier = 2, seal = xi.keyItem.CERISE_SEAL},        -- Anantaboga
    {item = xi.items.LUMP_OF_BONE_CHARCOAL,         tier = 2, seal = xi.keyItem.CERISE_SEAL},        -- Reacton
    {item = xi.items.PINCH_OF_GRANULATED_SUGAR,     tier = 2, seal = xi.keyItem.CERISE_SEAL},        -- Dextrose
    {item = xi.items.VIAL_OF_PURE_BLOOD,            tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL},-- Nosferatu
    {item = xi.items.VINEGAR_PIE,                   tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL},-- Khromasoul Bhurborlor
    {item = xi.items.JAR_OF_ROCK_JUICE,             tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL},-- Achamoth
    {item = xi.items.CHUNK_OF_BUFFALO_CORPSE,       tier = 4, seal = {xi.keyItem.COPPER_COLORED_SEAL,-- Sarameya
                                                                 xi.keyItem.GOLD_COLORED_SEAL,
                                                                 xi.keyItem.PURPLISH_GREY_SEAL}},
    {item = xi.items.PILE_OF_GOLDEN_TEETH,          tier = 1, seal = 0},                             -- Velionis
    {item = xi.items.GREENLING,                     tier = 1, seal = 0},                             -- Lil' Apkallu
    {item = xi.items.BOTTLE_OF_SPOILT_BLOOD,        tier = 1, seal = 0},                             -- Chigre
    {item = xi.items.OPALUS_GEM,                    tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL},    -- Wulgaru
    {item = xi.items.MERROW_NO_11_MOLTING,          tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL},    -- Zareehkl the Jubilant
    {item = xi.items.MINT_DROP,                     tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL},    -- Verdelet
    {item = xi.items.BOUND_EXORCISM_TREATISE,       tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL}, -- Mahjlaef the Paintorn
    {item = xi.items.CLUMP_OF_MYRRH,                tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL}, -- Experimental Lamia
    {item = xi.items.WHOLE_ROSE_SCAMPI,             tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL}, -- Nuhn
    {item = xi.items.CHUNK_OF_SINGED_BUFFALO,       tier = 4, seal = {xi.keyItem.TAUPE_COLORED_SEAL, -- Tyger
                                                                 xi.keyItem.FALLOW_COLORED_SEAL,
                                                                 xi.keyItem.SIENNA_COLORED_SEAL}},
    {item = xi.items.PANDEMONIUM_KEY,               tier = 5, seal = {xi.keyItem.LILAC_COLORED_SEAL, -- Pandemonium Warden
                                                                 xi.keyItem.LAVENDER_COLORED_SEAL,
                                                                 xi.keyItem.CHESTNUT_COLORED_SEAL}}
}

------------------------------------------------------------
---- Sanraku's ZNM Menu Options
----
---- ZNM order is the same as in pop_items
------------------------------------------------------------
-- Default: Tier 1 ZNMs + "Don't Ask"
-- (bit = 0: add ZNM to Sanraku's Menu)
xi.znm.DefaultMenu = 0x7F8FE3F8

-- Adjusts the bitmask based on owned seals
xi.znm.KeyItem_Params = {
    [0x38]          = xi.keyItem.MAROON_SEAL,               -- Tinnin T2 ZNMs
    [0x1C0]         = xi.keyItem.APPLE_GREEN_SEAL,          -- Tinnin T3 ZNMs
    [0xE000]        = xi.keyItem.CERISE_SEAL,               -- Sarameya T2 ZNMs
    [0x70000]       = xi.keyItem.SALMON_COLORED_SEAL,       -- Sarameya T3 ZNMs
    [0x3800000]     = xi.keyItem.PINE_GREEN_SEAL ,          -- Tyger T2 ZNMs
    [0x1C000000]    = xi.keyItem.AMBER_COLORED_SEAL,        -- Tyger T3 ZNMs
    [0x200]         = {xi.keyItem.CHARCOAL_GREY_SEAL,       -- Tinnin
                       xi.keyItem.DEEP_PURPLE_SEAL,
                       xi.keyItem.CHESTNUT_COLORED_SEAL},
    [0x80000]       = {xi.keyItem.PURPLISH_GREY_SEAL,       -- Sarameya
                       xi.keyItem.GOLD_COLORED_SEAL,
                       xi.keyItem.COPPER_COLORED_SEAL},
    [0x20000000]    = {xi.keyItem.TAUPE_COLORED_SEAL,       -- Tyger
                       xi.keyItem.FALLOW_COLORED_SEAL,
                       xi.keyItem.SIENNA_COLORED_SEAL},
    [0x40000000]    = {xi.keyItem.LILAC_COLORED_SEAL,       -- Pandemonium Warden
                       xi.keyItem.BRIGHT_BLUE_SEAL,
                       xi.keyItem.LAVENDER_COLORED_SEAL}
}