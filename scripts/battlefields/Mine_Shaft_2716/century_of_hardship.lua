-----------------------------------
-- A Century of Hardship
-- Mine Shaft #2716 mission battlefield
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.MINE_SHAFT_2716,
    battlefieldId         = xi.battlefield.id.CENTURY_OF_HARDSHIP,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 60,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = '_0d0',
    exitNpcs              = { '_0d1', '_0d2', '_0d3' },
    missionArea           = xi.mission.log_id.COP,
    mission               = xi.mission.id.cop.THREE_PATHS,
    missionStatus         = xi.mission.status.COP.LOUVERANCE,
    missionStatusArea     = xi.mission.log_id.COP,
    requiredMissionStatus = 8,
    grantXP               = 1000,
})

content.groups =
{
    {
        mobIds =
        {
            {
                mineshaftID.mob.MOVAMUQ,
                mineshaftID.mob.MOVAMUQ + 1,
                mineshaftID.mob.MOVAMUQ + 2,
                mineshaftID.mob.MOVAMUQ + 3,
                mineshaftID.mob.MOVAMUQ + 4,
            },

            {
                mineshaftID.mob.MOVAMUQ + 5,
                mineshaftID.mob.MOVAMUQ + 6,
                mineshaftID.mob.MOVAMUQ + 7,
                mineshaftID.mob.MOVAMUQ + 8,
                mineshaftID.mob.MOVAMUQ + 9,
            },

            {
                mineshaftID.mob.MOVAMUQ + 10,
                mineshaftID.mob.MOVAMUQ + 11,
                mineshaftID.mob.MOVAMUQ + 12,
                mineshaftID.mob.MOVAMUQ + 13,
                mineshaftID.mob.MOVAMUQ + 14,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
