-----------------------------------
-- Area: Sealion's Den
-- Name: The Warrior's Path
-----------------------------------
local sealionsDenID = zones[xi.zone.SEALIONS_DEN]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.SEALIONS_DEN,
    battlefieldId = xi.battlefield.id.WARRIORS_PATH,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = '_0w0',
    exitNpc       = 'Airship_Door',
    missionArea   = xi.mission.log_id.COP,
    mission       = xi.mission.id.cop.THE_WARRIORS_PATH,
    requiredVar   = 'Mission[6][748]Status',
    requiredValue = 1,

    title = xi.title.THE_CHEBUKKIS_WORST_NIGHTMARE,
})

content.groups =
{
    {
        mobIds =
        {
            { sealionsDenID.mob.TENZEN     },
            { sealionsDenID.mob.TENZEN + 4 },
            { sealionsDenID.mob.TENZEN + 8 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            {
                sealionsDenID.mob.TENZEN + 1,
                sealionsDenID.mob.TENZEN + 2,
                sealionsDenID.mob.TENZEN + 3,
            },

            {
                sealionsDenID.mob.TENZEN + 5,
                sealionsDenID.mob.TENZEN + 6,
                sealionsDenID.mob.TENZEN + 7,
            },

            {
                sealionsDenID.mob.TENZEN + 9,
                sealionsDenID.mob.TENZEN + 10,
                sealionsDenID.mob.TENZEN + 11,
            },
        },
    },
}

return content:register()
