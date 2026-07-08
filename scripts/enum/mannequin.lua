-----------------------------------
-- Mannequin
-----------------------------------
xi = xi or {}
xi.mannequin = xi.mannequin or {}

-- Stored in Mannequin exdata
---@enum xi.mannequin.type
xi.mannequin.type =
{
    HUME_M   = 0x01,
    HUME_F   = 0x02,
    ELVAAN_M = 0x04,
    ELVAAN_F = 0x08,
    TARU_M   = 0x10,
    TARU_F   = 0x20,
    MITHRA   = 0x40,
    GALKA    = 0x80,
}

-- Stored in Mannequin exdata
---@enum xi.mannequin.pose
xi.mannequin.pose =
{
    NORMAL    = 0x00,
    SIT       = 0x01,
    SALUTE_S  = 0x02, -- San d'Orian salute
    SALUTE_B  = 0x03, -- Bastokan salute
    SALUTE_W  = 0x04, -- Windurstian salute
    HURRAY    = 0x08,
    SPECIAL   = 0x10,
}
