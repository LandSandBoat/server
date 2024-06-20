-----------------------------------
-- Area: Roar! A Cat Burglar Bares Her Fangs
-- Name: A Moogle Kupo d'Etat Mission 10
-- !pos -221 -24 19 206
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId         = xi.battlefield.id.CAT_BURGLAR_BARES_FANGS,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 8,
    allowedAreas          = set{ 1 },
    entryNpc              = 'SC_Entrance',
    exitNpc               = 'Shimmering_Circle',
    requiredKeyItems      = { xi.ki.NAVARATNA_TALISMAN, onlyInitiator = true },

    -- TODO: Currently AMK does not depend on this fight in mission scripts.  Verify
    -- that this mission status is updated/correct once doing so.
    missionArea           = xi.mission.log_id.AMK,
    mission               = xi.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS,
    missionStatusArea     = xi.mission.log_id.AMK,
    requiredMissionStatus = 0,

    experimental = true,
})

content.groups =
{
    {
        mobIds =
        {
            { chamberOfOraclesID.mob.NANAA_MIHGO      },
            { chamberOfOraclesID.mob.NANAA_MIHGO + 6  },
            { chamberOfOraclesID.mob.NANAA_MIHGO + 12 },
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
                chamberOfOraclesID.mob.NANAA_MIHGO + 3,
                chamberOfOraclesID.mob.NANAA_MIHGO + 4,
                chamberOfOraclesID.mob.NANAA_MIHGO + 5,
            },

            {
                chamberOfOraclesID.mob.NANAA_MIHGO + 9,
                chamberOfOraclesID.mob.NANAA_MIHGO + 10,
                chamberOfOraclesID.mob.NANAA_MIHGO + 11,
            },

            {
                chamberOfOraclesID.mob.NANAA_MIHGO + 15,
                chamberOfOraclesID.mob.NANAA_MIHGO + 16,
                chamberOfOraclesID.mob.NANAA_MIHGO + 17,
            },
        },

        superlinkGroup = 1,
    },

    {
        mobIds =
        {
            {
                chamberOfOraclesID.mob.NANAA_MIHGO + 1,
                chamberOfOraclesID.mob.NANAA_MIHGO + 2,
            },

            {
                chamberOfOraclesID.mob.NANAA_MIHGO + 7,
                chamberOfOraclesID.mob.NANAA_MIHGO + 8,
            },

            {
                chamberOfOraclesID.mob.NANAA_MIHGO + 13,
                chamberOfOraclesID.mob.NANAA_MIHGO + 14,
            },
        },

        spawned        = false,
        superlinkGroup = 1,
    },

}

return content:register()
