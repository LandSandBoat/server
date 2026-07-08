xi = xi or {}

---@enum xi.immunity
xi.immunity =
{
    NONE        = 0x00000000, --      0
    ADDLE       = 0x00000001, --      1
    GRAVITY     = 0x00000002, --      2
    BIND        = 0x00000004, --      4
    STUN        = 0x00000008, --      8
    SILENCE     = 0x00000010, --     16
    PARALYZE    = 0x00000020, --     32
    BLIND       = 0x00000040, --     64
    SLOW        = 0x00000080, --    128
    POISON      = 0x00000100, --    256
    ELEGY       = 0x00000200, --    512
    REQUIEM     = 0x00000400, --   1024
    LIGHT_SLEEP = 0x00000800, --   2048
    DARK_SLEEP  = 0x00001000, --   4096
    ASPIR       = 0x00002000, --   8192
    TERROR      = 0x00004000, --  16384
    DISPEL      = 0x00008000, --  32768
    PETRIFY     = 0x00010000, --  65536
    PLAGUE      = 0x00020000, -- 131064
}
