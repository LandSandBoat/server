-----------------------------------
-- Flags during events
-----------------------------------
xi = xi or {}

-- Note: events have opcodes that can set flags internally, these can be ignored or set for each unique cutscene.
---@enum xi.cutsceneFlag
xi.cutsceneFlag =
{
    UNKNOWN_1       = 0x0001, -- Commonly set, effect unknown
    NO_PCS          = 0x0002, -- Do not display other Player Characters
    UNKNOWN_3       = 0x0004, -- Unknown
    UNKNOWN_4       = 0x0008, -- Unknown
    NO_NPCS         = 0x0010, -- Do not display NPCs and Mobs
    UNKNOWN_5       = 0x0020, -- Unknown
    UNKNOWN_6       = 0x0040, -- Unknown
    UNKNOWN_2       = 0x0080, -- Commonly set, effect unknown
    UNKNOWN_7       = 0x0100, -- Unknown (possibly camera related)
    UNKNOWN_8       = 0x0200, -- Unknown
    UNKNOWN_9       = 0x0400, -- Unknown
    UNKNOWN_10      = 0x0800, -- Unknown
    UNKNOWN_11      = 0x1000, -- Unknown
    UNKNOWN_12      = 0x2000, -- Unknown
    UNKNOWN_13      = 0x4000, -- Unknown
    UNKNOWN_14      = 0x8000, -- Unknown
}
