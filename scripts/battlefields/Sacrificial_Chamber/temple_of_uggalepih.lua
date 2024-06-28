-----------------------------------
-- Temple of Uggalepih
-- Sacrifical Chamber Mission Battlefield
-----------------------------------
local sacrificialChamberID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.SACRIFICIAL_CHAMBER,
    battlefieldId         = xi.battlefield.id.TEMPLE_OF_UGGALEPIH,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = '_4j0',
    exitNpcs              = { '_4j2', '_4j3', '_4j4' },
    missionArea           = xi.mission.log_id.ZILART,
    mission               = xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH,
    missionStatusArea     = xi.mission.log_id.ZILART,
    requiredMissionStatus = 0,
})

content.groups =
{
    {
        mobIds =
        {
            {
                sacrificialChamberID.mob.GRAVITON,
                sacrificialChamberID.mob.GRAVITON + 1,
                sacrificialChamberID.mob.GRAVITON + 2,
            },

            {
                sacrificialChamberID.mob.GRAVITON + 5,
                sacrificialChamberID.mob.GRAVITON + 6,
                sacrificialChamberID.mob.GRAVITON + 7,
            },

            {
                sacrificialChamberID.mob.GRAVITON + 10,
                sacrificialChamberID.mob.GRAVITON + 11,
                sacrificialChamberID.mob.GRAVITON + 12,
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
            { sacrificialChamberID.mob.GRAVITON + 3  },
            { sacrificialChamberID.mob.GRAVITON + 8  },
            { sacrificialChamberID.mob.GRAVITON + 13 },
        },
    },

    -- Avatar
    {
        mobIds =
        {
            { sacrificialChamberID.mob.GRAVITON + 4  },
            { sacrificialChamberID.mob.GRAVITON + 9  },
            { sacrificialChamberID.mob.GRAVITON + 14 },
        },

        spawned = false,
    },
}

return content:register()
