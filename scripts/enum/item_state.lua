-----------------------------------
-- Item State
-----------------------------------
xi = xi or {}

---@enum xi.itemState
xi.itemState =
{
    FREE             = 0,
    EQUIPPED         = 1,
    BAZAAR           = 2,
    PLACED_FURNITURE = 3,
    IN_TRANSACTION   = 4,
}
