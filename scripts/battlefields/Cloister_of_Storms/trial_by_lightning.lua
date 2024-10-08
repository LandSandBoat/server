-----------------------------------
-- Area: Cloister of Storms
-- BCNM: Trial by Lightning
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_STORMS,
    battlefieldId    = xi.battlefield.id.TRIAL_BY_LIGHTNING,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'LP_Entrance',
    exitNpc          = 'Lightning_Protocrystal',
    requiredKeyItems = { xi.ki.TUNING_FORK_OF_LIGHTNING },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING,
})

function content:onEventFinishWin(player, csid, option, npc)
    player:addTitle(xi.title.HEIR_OF_THE_GREAT_LIGHTNING)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_STORMS)
end

content.groups =
{
    {
        mobs = { 'Ramuh_Prime_TBL' },
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
