-----------------------------------
-- Tango with a Tracker
-- Boneyard Gully quest battlefield
-- !addkeyitem 719
-- TODO: Players that have completed the quest do not need a key item.
-----------------------------------
local boneyardGullyID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.TANGO_WITH_A_TRACKER,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 5,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    requiredKeyItems = { xi.keyItem.LETTER_FROM_SHIKAREE_X, message = boneyardGullyID.text.BURSTS_INTO_FLAMES },
    questArea        = xi.questLog.OTHER_AREAS,
    quest            = xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER,
    requiredVar      = 'Quest[4][82]Prog',
    requiredValue    = 1,
    experimental     = true,
})

-- There are many different Shikaree Z groups. Can't grab the first one.
local offsetID = boneyardGullyID.mob.SHIKAREE_Z_ROS

content.groups =
{
    {
        mobIds =
        {
            {
                offsetID + 1,   -- Shikaree Y
                offsetID + 2,   -- Shikaree X
                offsetID + 4,   -- Shikaree X's Rabbit
            },

            {
                offsetID + 7,   -- Shikaree Y
                offsetID + 8,   -- Shikaree X
                offsetID + 10,  -- Shikaree X's Rabbit
            },

            {
                offsetID + 13,  -- Shikaree Y
                offsetID + 14,  -- Shikaree X
                offsetID + 16,  -- Shikaree X's Rabbit
            },
        },

        superlinkGroup = 1,
        allDeath       = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
