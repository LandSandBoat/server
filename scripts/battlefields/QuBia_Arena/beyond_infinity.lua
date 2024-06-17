-----------------------------------
-- Beyond Infinity
-- Qu'Bia Arena Level Break
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.BEYOND_INFINITY,
    canLoseExp    = false,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 99,
    timeLimit     = utils.minutes(10),
    index         = 21,
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
            qubiaID.text.SOUL_GEM_REACTS,
            {
                xi.ki.SOUL_GEM_CLASP,
                xi.ki.SOUL_GEM,
            }
        },
        deleteMessage = qubiaID.text.LOST_KEYITEM,
    },
})

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.ATORI_TUTORI     },
            { qubiaID.mob.ATORI_TUTORI + 1 },
            { qubiaID.mob.ATORI_TUTORI + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
