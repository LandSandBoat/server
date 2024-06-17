-----------------------------------
-- Area: Chamber of Oracles
-- Name: Zilart Mission 6
-- !pos -221 -24 19 206
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId         = xi.battlefield.id.THROUGH_THE_QUICKSAND_CAVES,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = 'SC_Entrance',
    exitNpc               = 'Shimmering_Circle',
    missionArea           = xi.mission.log_id.ZILART,
    mission               = xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES,
    missionStatusArea     = xi.mission.log_id.ZILART,
    requiredMissionStatus = 0,
})

content.groups =
{
    {
        mobIds =
        {
            {
                chamberOfOraclesID.mob.CENTURIO_V_III,
                chamberOfOraclesID.mob.CENTURIO_V_III + 1,
                chamberOfOraclesID.mob.CENTURIO_V_III + 2,
            },

            {
                chamberOfOraclesID.mob.CENTURIO_V_III + 3,
                chamberOfOraclesID.mob.CENTURIO_V_III + 4,
                chamberOfOraclesID.mob.CENTURIO_V_III + 5,
            },

            {
                chamberOfOraclesID.mob.CENTURIO_V_III + 6,
                chamberOfOraclesID.mob.CENTURIO_V_III + 7,
                chamberOfOraclesID.mob.CENTURIO_V_III + 8,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
