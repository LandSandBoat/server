-----------------------------------
-- Area: Cloister of Tremors
-- BCNM: Trial by Earth
-----------------------------------
local cloisterOfTremorsID = zones[xi.zone.CLOISTER_OF_TREMORS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TREMORS,
    battlefieldId    = xi.battlefield.id.TRIAL_BY_EARTH,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'EP_Entrance',
    exitNpc          = 'Earth_Protocrystal',
    requiredKeyItems = { xi.ki.TUNING_FORK_OF_EARTH },

    questArea = xi.questLog.BASTOK,
    quest     = xi.quest.id.bastok.TRIAL_BY_EARTH,
})

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfTremorsID.mob.TITAN_PRIME     },
            { cloisterOfTremorsID.mob.TITAN_PRIME + 1 },
            { cloisterOfTremorsID.mob.TITAN_PRIME + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
