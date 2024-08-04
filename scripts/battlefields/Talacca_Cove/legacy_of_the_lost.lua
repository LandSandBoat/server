-----------------------------------
-- Area: Talacca Cove
-- BCNM: TOAU-34 Legacy of the Lost
-----------------------------------
local talaccaCoveID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.TALACCA_COVE,
    battlefieldId         = xi.battlefield.id.LEGACY_OF_THE_LOST,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 99,
    timeLimit             = utils.minutes(30),
    index                 = 4,
    allowedAreas          = set{ 1 },
    entryNpc              = '_1l0',
    exitNpcs              = { '_1l1', '_1l2', '_1l3' },
    missionArea           = xi.mission.log_id.TOAU,
    mission               = xi.mission.id.toau.LEGACY_OF_THE_LOST,
    requiredMissionStatus = 0,

    title = xi.title.GESSHOS_MERCY,
})

content.groups =
{
    {
        mobIds =
        {
            -- TODO: Gessho is missing logic in its mob script for text
            -- displayed throughout the fight at minimum and may be missing additional
            -- mob mechanics along with improper spawning of clones.

            { talaccaCoveID.mob.GESSHO      },
            { talaccaCoveID.mob.GESSHO + 7  },
            { talaccaCoveID.mob.GESSHO + 14 },

        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            {
                talaccaCoveID.mob.GESSHO + 1,
                talaccaCoveID.mob.GESSHO + 2,
                talaccaCoveID.mob.GESSHO + 3,
                talaccaCoveID.mob.GESSHO + 4,
                talaccaCoveID.mob.GESSHO + 5,
                talaccaCoveID.mob.GESSHO + 6,
            },

            {
                talaccaCoveID.mob.GESSHO + 8,
                talaccaCoveID.mob.GESSHO + 9,
                talaccaCoveID.mob.GESSHO + 10,
                talaccaCoveID.mob.GESSHO + 11,
                talaccaCoveID.mob.GESSHO + 12,
                talaccaCoveID.mob.GESSHO + 13,
            },

            {
                talaccaCoveID.mob.GESSHO + 15,
                talaccaCoveID.mob.GESSHO + 16,
                talaccaCoveID.mob.GESSHO + 17,
                talaccaCoveID.mob.GESSHO + 18,
                talaccaCoveID.mob.GESSHO + 19,
                talaccaCoveID.mob.GESSHO + 20,
            },
        },

        spawned = false,
    },
}

return content:register()
