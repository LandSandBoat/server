-----------------------------------
-- Zone Types
-----------------------------------
xi = xi or {}

xi.zoneType =
{
    UNKNOWN   = 0x0000,
    CITY      = 0x0001,
    OUTDOORS  = 0x0002,
    DUNGEON   = 0x0004,
    SIGNET    = 0x0008,
    SANCTION  = 0x0010, -- 16
    SIGIL     = 0x0020, -- 32
    IONIS     = 0x0040, -- 64
    DYNAMIS   = 0x0080, -- 128
    INSTANCED = 0x0100, -- 256
}
