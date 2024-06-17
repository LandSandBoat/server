-----------------------------------
-- Desires of Emptiness
-- Spire of Vahzl mission battlefield
-----------------------------------
local spireOfVahzlID = zones[xi.zone.SPIRE_OF_VAHZL]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.SPIRE_OF_VAHZL,
    battlefieldId         = xi.battlefield.id.DESIRES_OF_EMPTINESS,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 50,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = '_0n0',
    exitNpcs              = { '_0n1', '_0n2', '_0n3' },
    missionArea           = xi.mission.log_id.COP,
    mission               = xi.mission.id.cop.DESIRES_OF_EMPTINESS,
    requiredVar           = 'Mission[6][518]Status',
    requiredValue         = 2,

    grantXP = 1500,
    title   = xi.title.FROZEN_DEAD_BODY,
})

content.groups =
{
    {
        mobIds =
        {
            {
                spireOfVahzlID.mob.AGONIZER,
                spireOfVahzlID.mob.AGONIZER + 1,
                spireOfVahzlID.mob.AGONIZER + 6,
            },

            {
                spireOfVahzlID.mob.AGONIZER + 7,
                spireOfVahzlID.mob.AGONIZER + 8,
                spireOfVahzlID.mob.AGONIZER + 13,
            },

            {
                spireOfVahzlID.mob.AGONIZER + 14,
                spireOfVahzlID.mob.AGONIZER + 15,
                spireOfVahzlID.mob.AGONIZER + 20,
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
                spireOfVahzlID.mob.AGONIZER + 2,
                spireOfVahzlID.mob.AGONIZER + 3,
                spireOfVahzlID.mob.AGONIZER + 4,
                spireOfVahzlID.mob.AGONIZER + 5,
            },

            {
                spireOfVahzlID.mob.AGONIZER + 9,
                spireOfVahzlID.mob.AGONIZER + 10,
                spireOfVahzlID.mob.AGONIZER + 11,
                spireOfVahzlID.mob.AGONIZER + 12,
            },

            {
                spireOfVahzlID.mob.AGONIZER + 16,
                spireOfVahzlID.mob.AGONIZER + 17,
                spireOfVahzlID.mob.AGONIZER + 18,
                spireOfVahzlID.mob.AGONIZER + 19,
            },
        },

        spawned = false,
    },
}

return content:register()
