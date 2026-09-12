-----------------------------------
-- Beyond Infinity
-- Balgas Dais Level Break
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.BALGAS_DAIS,
    battlefieldId = xi.battlefield.id.BEYOND_INFINITY_BALGAS_DAIS,
    canLoseExp    = false,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = xi.settings.main.MAX_LEVEL,
    timeLimit     = utils.minutes(10),
    index         = 20,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',

    questArea = xi.questLog.JEUNO,
    quest     = xi.quest.id.jeuno.BEYOND_INFINITY,

    requiredKeyItems =
    {
        xi.keyItem.SOUL_GEM_CLASP,
        onlyInitiator = true,
        message =
        {
            balgasID.text.SOUL_GEM_REACTS,
            {
                xi.keyItem.SOUL_GEM_CLASP,
                xi.keyItem.SOUL_GEM,
            }
        },
        deleteMessage = balgasID.text.LOST_KEYITEM,
    },
})

content.groups =
{
    {
        mobIds =
        {
            { balgasID.mob.ATORI_TUTORI     },
            { balgasID.mob.ATORI_TUTORI + 1 },
            { balgasID.mob.ATORI_TUTORI + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
