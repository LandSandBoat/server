-----------------------------------
-- Target flags
-- Used for both "who can be targeted" and "who is affected by AOE"
-----------------------------------
xi = xi or {}

---@enum xi.target
xi.target =
{
    NONE     = 0x00,
    SELF     = 0x01, -- Self
    PET      = 0x02, -- My own pet
    PARTY    = 0x04, -- Party members
    ALLIANCE = 0x08, -- Alliance members
    FRIENDLY = 0x10, -- Same allegiance
    HOSTILE  = 0x20, -- Different allegiance
    MASTER   = 0x40, -- My own master
    DEAD     = 0x80, -- Dead entities
}
