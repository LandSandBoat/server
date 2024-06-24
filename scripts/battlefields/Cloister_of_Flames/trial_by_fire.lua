-----------------------------------
-- Area: Cloister of Flames
-- BCNM: Trial by Fire
-----------------------------------
local cloisterOfFlamesID = zones[xi.zone.CLOISTER_OF_FLAMES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FLAMES,
    battlefieldId    = xi.battlefield.id.TRIAL_BY_FIRE,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'FP_Entrance',
    exitNpc          = 'Fire_Protocrystal',
    requiredKeyItems = { xi.ki.TUNING_FORK_OF_FIRE },

    questArea = xi.questLog.OUTLANDS,
    quest     = xi.quest.id.outlands.TRIAL_BY_FIRE,
})

function content:onEventFinishWin(player, csid, option, npc)
    player:addTitle(xi.title.HEIR_OF_THE_GREAT_FIRE)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_FLAMES)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfFlamesID.mob.IFRIT_PRIME     },
            { cloisterOfFlamesID.mob.IFRIT_PRIME + 1 },
            { cloisterOfFlamesID.mob.IFRIT_PRIME + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
