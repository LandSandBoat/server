-----------------------------------
-- FINDFLAGS enum
-- determines which targets to attempt to add to targetfind (will check for valid target before entry)
-----------------------------------
xi = xi or {}

---@enum xi.findFlag
xi.findFlag =
{
    NONE            = 0,
    DEAD            = 1,  -- target dead
    ALLIANCE        = 2,  -- force target alliance
    PET             = 4,  -- force target pet
    -- 8 and 16 are available
    IGNORE_BATTLEID = 32, -- ignore battle id check
}
