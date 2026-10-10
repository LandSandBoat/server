-----------------------------------
-- Monstrosity - Constants
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-----------------------------------
-- Feretory
-----------------------------------
xi.monstrosity.feretoryEntrance = { x = -358, y = -3.4, z = -440, rot = 64 }

-- The client lists the starters as rabbit, lizard, mandragora.
xi.monstrosity.starterCutsceneIndex =
{
    [xi.monstrositySpecies.RABBIT    ] = 1,
    [xi.monstrositySpecies.LIZARD    ] = 2,
    [xi.monstrositySpecies.MANDRAGORA] = 3,
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
