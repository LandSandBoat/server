-----------------------------------
-- Beyond Infinity
-- Horlais Peak Level Break
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.HORLAIS_PEAK,
    battlefieldId = xi.battlefield.id.BEYOND_INFINITY_HORLAIS_PEAK,
    canLoseExp    = false,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 99,
    timeLimit     = utils.minutes(10),
    index         = 20,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',

    questArea = xi.questLog.JEUNO,
    quest     = xi.quest.id.jeuno.BEYOND_INFINITY,

    requiredKeyItems =
    {
        xi.ki.SOUL_GEM_CLASP,
        onlyInitiator = true,
        message =
        {
            horlaisID.text.SOUL_GEM_REACTS,
            {
                xi.ki.SOUL_GEM_CLASP,
                xi.ki.SOUL_GEM,
            }
        },
        deleteMessage = horlaisID.text.LOST_KEYITEM,
    },
})

content.groups =
{
    {
        mobIds =
        {
            { horlaisID.mob.ATORI_TUTORI     },
            { horlaisID.mob.ATORI_TUTORI + 1 },
            { horlaisID.mob.ATORI_TUTORI + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
