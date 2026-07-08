-----------------------------------
-- Brenner
-----------------------------------
xi = xi or {}
xi.brenner = xi.brenner or {}

--- Level cap for Brenner matches stored in book/page exdata for client rendering
---@enum xi.brenner.levelCap
xi.brenner.levelCap =
{
    UNCAPPED = 0,
    LV60     = 1,
    LV50     = 2,
    LV40     = 3,
    LV30     = 4,
    LV20     = 5,
    LV10     = 6,
}
