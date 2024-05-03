-----------------------------------
-- A Thief in Norg?!
-- Waughroon Shrine quest battlefield
-- !pos -345 104 -260 144
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.THIEF_IN_NORG,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 4,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.BANISHING_CHARM },

    questArea = xi.questLog.OUTLANDS,
    quest     = xi.quest.id.outlands.A_THIEF_IN_NORG,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return xi.quest.getVar(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG, 'Prog') == 6
end

content.groups =
{
    {
        mobIds =
        {
            {
                waughroonID.mob.GAKI[1],
                waughroonID.mob.GAKI[1] + 1,
                waughroonID.mob.GAKI[1] + 2,
                waughroonID.mob.GAKI[1] + 3,
            },

            {
                waughroonID.mob.GAKI[2],
                waughroonID.mob.GAKI[2] + 1,
                waughroonID.mob.GAKI[2] + 2,
                waughroonID.mob.GAKI[2] + 3,
            },

            {
                waughroonID.mob.GAKI[3],
                waughroonID.mob.GAKI[3] + 1,
                waughroonID.mob.GAKI[3] + 2,
                waughroonID.mob.GAKI[3] + 3,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            { waughroonID.mob.GAKI[1] + 4, },
            { waughroonID.mob.GAKI[2] + 4, },
            { waughroonID.mob.GAKI[3] + 4, },
        },

        spawned = false,
    },
}

return content:register()
