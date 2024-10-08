-----------------------------------
-- Area: Cloister of Tides
-- BCNM: Trial by Water
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TIDES,
    battlefieldId    = xi.battlefield.id.TRIAL_BY_WATER,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Water_Protocrystal',
    requiredKeyItems = { xi.ki.TUNING_FORK_OF_WATER },

    questArea = xi.questLog.OUTLANDS,
    quest     = xi.quest.id.outlands.TRIAL_BY_WATER,
})

function content:onEventFinishWin(player, csid, option, npc)
    player:addTitle(xi.title.HEIR_OF_THE_GREAT_WATER)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_TIDES)
end

content.groups =
{
    {
        mobs = { 'Leviathan_Prime_TBW' },
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
