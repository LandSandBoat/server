-----------------------------------
-- Roam flags
-----------------------------------
xi = xi or {}

xi.roamFlag =
{
    NONE     = 0x000,
    NONE0    = 0x001,
    NONE1    = 0x002,
    NONE2    = 0x004,
    NONE3    = 0x008,
    NONE4    = 0x010,
    NONE5    = 0x020,
    WORM     = 0x040, -- pop up and down when moving
    AMBUSH   = 0x080, -- stays hidden until someone comes close (antlion)
    SCRIPTED = 0x100, -- calls lua method for roaming logic
    IGNORE   = 0x200, -- ignore all hate, except linking hate
    STEALTH  = 0x400, -- stays name hidden and untargetable until someone comes close (chigoe)
}
