-----------------------------------
-- Area: Cloister of Tremors
-- BCNM: The Puppet Master
-- !pos -539 1 -493 209
-----------------------------------
local cloisterOfTremorsID = zones[xi.zone.CLOISTER_OF_TREMORS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TREMORS,
    battlefieldId    = xi.battlefield.id.PUPPET_MASTER,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'EP_Entrance',
    exitNpc          = 'Earth_Protocrystal',
    requiredItems    = { xi.item.EARTH_PENDULUM },
    requiredVar      = 'Quest[2][81]Prog',
    requiredValue    = 1,

    questArea = xi.questLog.WINDURST,
    quest     = xi.quest.id.windurst.THE_PUPPET_MASTER,
})

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfTremorsID.mob.GALGALIM     },
            { cloisterOfTremorsID.mob.GALGALIM + 1 },
            { cloisterOfTremorsID.mob.GALGALIM + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
