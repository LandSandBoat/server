-----------------------------------
-- Area: Smash! A Malevolent Menace
-- Name: A Moogle Kupo d'Etat Mission 14
-- !pos -111 -6 0.1 165
-----------------------------------
local throneRoomID = zones[xi.zone.THRONE_ROOM]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId           = xi.zone.THRONE_ROOM,
    battlefieldId    = xi.battlefield.id.SMASH_A_MALEVOLENT_MENACE,
    canLoseExp       = false,
    isMission        = true,
    allowTrusts      = true,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 4,
    allowedAreas     = set{ 1 },
    entryNpc         = '_4l1',
    exitNpcs         = { '_4l2', '_4l3', '_4l4' },
    requiredKeyItems = { xi.ki.MEGA_BONANZA_KUPON, onlyInitiator = true },

    -- TODO: Currently AMK does not depend on this fight in mission scripts.  Verify
    -- that this mission status is updated/correct once doing so.
    missionArea           = xi.mission.log_id.AMK,
    mission               = xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE,
    missionStatusArea     = xi.mission.log_id.AMK,
    requiredMissionStatus = 0,

    experimental = true,
})

content.groups =
{
    {
        mobIds =
        {
            { throneRoomID.mob.RIKO_KUPENREICH      },
            { throneRoomID.mob.RIKO_KUPENREICH + 10 },
            { throneRoomID.mob.RIKO_KUPENREICH + 20 },
        },

        superlinkGroup = 1,
        allDeath       = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            {
                throneRoomID.mob.RIKO_KUPENREICH + 1,
                throneRoomID.mob.RIKO_KUPENREICH + 2,
                throneRoomID.mob.RIKO_KUPENREICH + 3,
                throneRoomID.mob.RIKO_KUPENREICH + 4,
                throneRoomID.mob.RIKO_KUPENREICH + 5,
                throneRoomID.mob.RIKO_KUPENREICH + 6,
                throneRoomID.mob.RIKO_KUPENREICH + 7,
                throneRoomID.mob.RIKO_KUPENREICH + 8,
                throneRoomID.mob.RIKO_KUPENREICH + 9,
            },

            {
                throneRoomID.mob.RIKO_KUPENREICH + 11,
                throneRoomID.mob.RIKO_KUPENREICH + 12,
                throneRoomID.mob.RIKO_KUPENREICH + 13,
                throneRoomID.mob.RIKO_KUPENREICH + 14,
                throneRoomID.mob.RIKO_KUPENREICH + 15,
                throneRoomID.mob.RIKO_KUPENREICH + 16,
                throneRoomID.mob.RIKO_KUPENREICH + 17,
                throneRoomID.mob.RIKO_KUPENREICH + 18,
                throneRoomID.mob.RIKO_KUPENREICH + 19,
            },

            {
                throneRoomID.mob.RIKO_KUPENREICH + 21,
                throneRoomID.mob.RIKO_KUPENREICH + 22,
                throneRoomID.mob.RIKO_KUPENREICH + 23,
                throneRoomID.mob.RIKO_KUPENREICH + 24,
                throneRoomID.mob.RIKO_KUPENREICH + 25,
                throneRoomID.mob.RIKO_KUPENREICH + 26,
                throneRoomID.mob.RIKO_KUPENREICH + 27,
                throneRoomID.mob.RIKO_KUPENREICH + 28,
                throneRoomID.mob.RIKO_KUPENREICH + 29,
            },
        },

        superlinkGroup = 1,
        spawned        = false,
    },
}

return content:register()
