-----------------------------------
-- Gardening
-----------------------------------
xi = xi or {}
xi.gardening = xi.gardening or {}

---@enum xi.gardening.stage
xi.gardening.stage =
{
    EMPTY                  = 0,
    INITIAL                = 1,
    FIRST_SPROUTS          = 2,
    FIRST_SPROUTS_2        = 3,
    FIRST_SPROUTS_CRYSTAL  = 4,
    SECOND_SPROUTS         = 5,
    SECOND_SPROUTS_2       = 6,
    SECOND_SPROUTS_CRYSTAL = 7,
    SECOND_SPROUTS_3       = 8,
    THIRD_SPROUTS          = 9,
    MATURE_PLANT           = 10,
    WILTED                 = 11,
}

---@enum xi.gardening.plant
xi.gardening.plant =
{
    NONE            = 0,
    FRUIT_SEEDS     = 1,
    HERB_SEEDS      = 2,
    GRAIN_SEEDS     = 3,
    VEGETABLE_SEEDS = 4,
    CACTUS_STEMS    = 5,
    TREE_CUTTINGS   = 6,
    TREE_SAPLINGS   = 7,
    WILDGRASS_SEEDS = 8,
}
