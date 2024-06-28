-----------------------------------
-- The Secret Weapon
-- Horlais Peak mission battlefield
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.HORLAIS_PEAK,
    battlefieldId         = xi.battlefield.id.THE_SECRET_WEAPON,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 3,
    entryNpc              = 'BC_Entrance',
    exitNpc               = 'Burning_Circle',
    missionArea           = xi.mission.log_id.SANDORIA,
    mission               = xi.mission.id.sandoria.THE_SECRET_WEAPON,
    missionStatusArea     = xi.mission.log_id.SANDORIA,
    requiredMissionStatus = 2,
})

content.groups =
{
    {
        mobIds =
        {
            {
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 1,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 2,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 3,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 4,
            },

            {
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 6,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 7,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 8,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 9,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 10,
            },

            {
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 12,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 13,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 14,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 15,
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 16,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            {
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 5,
            },

            {
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 11,
            },

            {
                horlaisID.mob.DAROKBOK_OF_CLAN_REAPER + 17,
            },
        },

        spawned = false,
    },
}

return content:register()
