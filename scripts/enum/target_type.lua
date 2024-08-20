-----------------------------------
-- TARGETTYPE enum
-- used to determine if a pending target is valid based on comparison to "attacker" entity
-----------------------------------
xi = xi or {}

---@enum targetType
xi.targetType =
{
    NONE                    = 0x00,
    SELF                    = 0x01,
    PLAYER_PARTY            = 0x02,
    ENEMY                   = 0x04,
    PLAYER_ALLIANCE         = 0x08,
    PLAYER                  = 0x10,
    PLAYER_DEAD             = 0x20,
    NPC                     = 0x40, -- an npc is a mob that looks like an npc and fights on the side of the character
    PLAYER_PARTY_PIANISSIMO = 0x80,
    PET                     = 0x100,
    PLAYER_PARTY_ENTRUST    = 0x200,
    IGNORE_BATTLEID         = 0x400, -- Can hit targets that do not have the same battle ID
}
