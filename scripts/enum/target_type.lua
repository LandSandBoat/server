-----------------------------------
-- TARGETTYPE enum
-- used to determine if a pending target is valid based on comparison to "attacker" entity
-----------------------------------
xi = xi or {}

---@enum xi.targetType
xi.targetType =
{
    NONE                    = 0x0000,
    SELF                    = 0x0001,
    PLAYER_PARTY            = 0x0002,
    ENEMY                   = 0x0004,
    PLAYER_ALLIANCE         = 0x0008,
    PLAYER                  = 0x0010,
    PLAYER_DEAD             = 0x0020,
    NPC                     = 0x0040, -- an npc is a mob that looks like an npc and fights on the side of the character
    PLAYER_PARTY_PIANISSIMO = 0x0080,
    PET                     = 0x0100,
    PLAYER_PARTY_ENTRUST    = 0x0200,
    IGNORE_BATTLEID         = 0x0400, -- Can hit targets that do not have the same battle ID
    ANY_ALLEGIANCE          = 0x0800, -- Can hit targets from any allegiance simultaneously. To be used with other flags above and only makes sense for non-single-target skills
}
