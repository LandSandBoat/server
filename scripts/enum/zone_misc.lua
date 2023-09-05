xi = xi or {}

xi.zoneMisc =
{
    NONE                  = 0x0000, -- Able to be used in any area
    ESCAPE                = 0x0001, -- Ability to use Escape Spell
    FELLOW                = 0x0002, -- Ability to summon Fellow NPC
    MOUNT                 = 0x0004, -- Ability to use Chocobos and mounts
    MAZURKA               = 0x0008, -- Ability to use Mazurka Spell
    TRACTOR               = 0x0010, -- Ability to use Tractor Spell
    MOGMENU               = 0x0020, -- Ability to communicate with Nomad Moogle (menu access mog house)
    COSTUME               = 0x0040, -- Ability to use a Costumes
    PET                   = 0x0080, -- Ability to summon Pets
    TREASURE              = 0x0100, -- Presence in the global zone TreasurePool
    AH                    = 0x0200, -- Ability to use the auction house
    YELL                  = 0x0400, -- Send and receive /yell commands
    TRUST                 = 0x0800, -- Ability to cast trust magic
    MISC_LOS_PLAYER_BLOCK = 0x1000, -- Players can't use magic/JAs through walls if this is set
    MISC_LOS_OFF          = 0x2000, -- Zone should not have LoS checks
}
