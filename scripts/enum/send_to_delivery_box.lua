-----------------------------------
-- Return codes for SendItemToDeliveryBox function
-----------------------------------
xi = xi or {}

---@enum sendToDBoxReturnCode
xi.sendToDBoxReturnCode =
{
    -- Successfully delivered the requested quantity
    SUCCESS                       = 0,
    -- Success but requested quantity was larger than
    -- item stack size so only delivered a single stack
    SUCCESS_LIMITED_TO_STACK_SIZE = 1,
    PLAYER_NOT_FOUND              = 2,
    ITEM_NOT_FOUND                = 3,
    QUERY_ERROR                   = 4
}
