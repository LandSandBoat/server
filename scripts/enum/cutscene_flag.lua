-----------------------------------
-- Flags during events
-----------------------------------
xi = xi or {}

-- Note: events have opcodes that can set flags internally, these can be ignored or set for each unique cutscene.
xi.cutsceneFlag =
{
    UNKNOWN_1       = 0x01, -- Commonly set, effect unknown
    NO_PCS          = 0x02, -- Do not display other Player Characters
    NO_NPCS         = 0x10, -- Do not display NPCs and Mobs
    UNKNOWN_2       = 0x80, -- Commonly set, effect unknown
}
