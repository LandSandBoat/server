xi = xi or {}

-- Check Lua item with:
-- local isEx = bit.band(item:getFlag(), xi.itemFlag.EX) ~= 0
xi.itemFlag =
{
    WALLHANGING  = 0x0001,
    -- 01          = 0x0002,
    MYSTERY_BOX  = 0x0004, -- Can be gained from Gobbie Mystery Box
    MOG_GARDEN   = 0x0008, -- Can use in Mog Garden
    MAIL2ACCOUNT = 0x0010, -- CanSendPOL Polutils Value
    INSCRIBABLE  = 0x0020,
    NOAUCTION    = 0x0040,
    SCROLL       = 0x0080,
    LINKSHELL    = 0x0100, -- Linkshell Polutils Value
    CANUSE       = 0x0200,
    CANTRADENPC  = 0x0400,
    CANEQUIP     = 0x0800,
    NOSALE       = 0x1000,
    NODELIVERY   = 0x2000,
    EX           = 0x4000, -- NoTradePC Polutils Value
    RARE         = 0x8000,
}
