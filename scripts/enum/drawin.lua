-----------------------------------
-- Drawin bits
-----------------------------------
xi = xi or {}

xi.drawin =
{
    NONE             = 0x000, -- no draw-in (mob can only draw-in by explictly calling the lua drawin function)
    NORMAL           = 0x001, -- basic draw-in where mob will draw-in battle target when target some distance from mob
    TO_FRONT_OF_MOB  = 0x002, -- determines if draw-in to the center of mob (bit not set) or front of mob (bit set)
    INCLUDE_ALLIANCE = 0x004, -- determines if draw-in includes just the battle target (bit not set) or entire alliance (bit set)
}
