-----------------------------------
-- Garrison Data
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

xi.garrison.data =
{
    [xi.zone.VALKURM_DUNES] =
    {
        levelCap = 30,
        npcs =
        {
            17201192, -- Trader
            17201193, -- Trader
        },
        waves =
        {
            {
                17199593, -- Goblin Swordmaker
                17199594, -- Goblin Swordmaker
            },
            {
                17199595, -- Goblin Leecher
                17199596, -- Goblin Leecher
            },
            {
                17199597, -- Goblin Gaoler
                17199598, -- Goblin Gaoler
            },
            {
                17199599, -- Goblin Gambler
                17199600, -- Goblin Gambler
                17199601, -- Goblin Swindler (NM)
            },
        },
    },
}
