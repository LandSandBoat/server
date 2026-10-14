-----------------------------------
-- Monstrosity - Constants
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-----------------------------------
-- Feretory
-----------------------------------
xi.monstrosity.feretoryEntrance = { x = -358, y = -3.4, z = -440, rot = 64 }

-- The Suspicious NPC's first event in each city. The rest follow in the order of cityEvent.
xi.monstrosity.cityEvents =
{
    [xi.zone.PASHHOW_MARSHLANDS] = 40,
    [xi.zone.NORTHERN_SAN_DORIA] = 882,
    [xi.zone.PORT_BASTOK]        = 418,
    [xi.zone.PORT_WINDURST]      = 880,
}

xi.monstrosity.cityEvent =
{
    CHATTER         = -1,
    INTRO           = 0,
    TRADE           = 1,
    HAS_RING        = 2,
    PASSAGE         = 3,
    GLADIATOR_INTRO = 4,
    GLADIATOR_MENU  = 5,
}

-----------------------------------
-- Belligerency
-----------------------------------
-- The zones are fixed by the client menu, the level caps are not (JP wiki, BG).
xi.monstrosity.belligerencyCaps =
{
    [xi.zone.BUBURIMU_PENINSULA] = 30,
    [xi.zone.XARCABARD]          = 60,
    [xi.zone.ULEGUERAND_RANGE]   = 90,
}
