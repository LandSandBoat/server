-----------------------------------
-- Area: Cloister of Gales
-- BCNM: Trial by Wind
-----------------------------------
local cloisterOfGalesID = zones[xi.zone.CLOISTER_OF_GALES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_GALES,
    battlefieldId    = xi.battlefield.id.TRIAL_BY_WIND,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Wind_Protocrystal',
    requiredKeyItems = { xi.ki.TUNING_FORK_OF_WIND },

    questArea = xi.questLog.OUTLANDS,
    quest     = xi.quest.id.outlands.TRIAL_BY_WIND,
})

function content:onEventFinishWin(player, csid, option, npc)
    player:addTitle(xi.title.HEIR_OF_THE_GREAT_WIND)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_GALES)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfGalesID.mob.GARUDA_PRIME     },
            { cloisterOfGalesID.mob.GARUDA_PRIME + 1 },
            { cloisterOfGalesID.mob.GARUDA_PRIME + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
