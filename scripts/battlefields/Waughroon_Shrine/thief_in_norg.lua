-----------------------------------
-- A Thief in Norg?!
-- Waughroon Shrine quest battlefield
-- !pos -345 104 -260 144
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.THIEF_IN_NORG,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 4,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.BANISHING_CHARM },

    questArea     = xi.questLog.OUTLANDS,
    quest         = xi.quest.id.outlands.A_THIEF_IN_NORG,
    requiredVar   = 'Quest[5][142]Prog',
    requiredValue = 6,
})

content.groups =
{
    {
        mobIds =
        {
            {
                waughroonID.mob.GAKI,
                waughroonID.mob.GAKI + 1,
                waughroonID.mob.GAKI + 2,
            },

            {
                waughroonID.mob.GAKI + 5,
                waughroonID.mob.GAKI + 6,
                waughroonID.mob.GAKI + 7,
            },

            {
                waughroonID.mob.GAKI + 10,
                waughroonID.mob.GAKI + 11,
                waughroonID.mob.GAKI + 12,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    -- Elemental
    {
        mobIds =
        {
            { waughroonID.mob.GAKI + 3  },
            { waughroonID.mob.GAKI + 8  },
            { waughroonID.mob.GAKI + 13 },
        },
    },

    -- Avatar
    {
        mobIds =
        {
            { waughroonID.mob.GAKI + 4  },
            { waughroonID.mob.GAKI + 9  },
            { waughroonID.mob.GAKI + 14 },
        },

        spawned = false,
    },
}

return content:register()
