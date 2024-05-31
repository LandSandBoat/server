-----------------------------------
-- Area: Riverne Site #B01
-- Name: Storms of Fate
-- !pos 299 -123 345 146
-----------------------------------
local riverneID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.RIVERNE_SITE_B01,
    battlefieldId = xi.battlefield.id.STORMS_OF_FATE,
    maxPlayers    = 18,
    timeLimit     = utils.minutes(30),
    index         = 0,
    area          = 1,
    entryNpc      = 'Unstable_Displacement',
    exitNpc       = 'SD_BCNM_Exit',
    questArea     = xi.questLog.JEUNO,
    quest         = xi.quest.id.jeuno.STORMS_OF_FATE,
    requiredVar   = 'StormsOfFate',
    requiredValue = 2,
})

function content:onEventFinishWin(player, csid, option, npc)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('StormsOfFate') == 2
    then
        npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_THE_WYRMKING)
        player:setCharVar('StormsOfFate', 3)
        player:addTitle(xi.title.CONQUEROR_OF_FATE)
    end
end

content.groups =
{
    {
        mobIds =
        {
            riverneID.mob.BAHAMUT,
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
