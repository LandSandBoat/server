-----------------------------------
-- On My Way
-- Waughroon Shrine mission battlefield
-- !pos -345 104 -260 144
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.WAUGHROON_SHRINE,
    battlefieldId         = xi.battlefield.id.ON_MY_WAY,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 3,
    entryNpc              = 'BC_Entrance',
    exitNpc               = 'Burning_Circle',
    missionArea           = xi.mission.log_id.BASTOK,
    mission               = xi.mission.id.bastok.ON_MY_WAY,
    missionStatusArea     = xi.mission.log_id.BASTOK,
    requiredMissionStatus = 2,
})

content.groups =
{
    {
        mobIds =
        {
            {
                waughroonID.mob.KUJHU_GRANITESKIN,
                waughroonID.mob.KUJHU_GRANITESKIN + 1,
                waughroonID.mob.KUJHU_GRANITESKIN + 2,
                waughroonID.mob.KUJHU_GRANITESKIN + 3,
            },

            {
                waughroonID.mob.KUJHU_GRANITESKIN + 4,
                waughroonID.mob.KUJHU_GRANITESKIN + 5,
                waughroonID.mob.KUJHU_GRANITESKIN + 6,
                waughroonID.mob.KUJHU_GRANITESKIN + 7,
            },

            {
                waughroonID.mob.KUJHU_GRANITESKIN + 8,
                waughroonID.mob.KUJHU_GRANITESKIN + 9,
                waughroonID.mob.KUJHU_GRANITESKIN + 10,
                waughroonID.mob.KUJHU_GRANITESKIN + 11,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
