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
    UNLIMITED       = 8,  -- unlimited distance
    HIT_ALL         = 16, -- hit all targets, regardless of party
    IGNORE_BATTLEID = 32, -- ignore battle id check
}
