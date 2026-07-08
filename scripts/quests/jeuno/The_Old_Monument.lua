-----------------------------------
-- The Old Monument
-----------------------------------
-- Log ID: 3, Quest ID: 11
-- Mertaire    : !pos -17 0 -61 245
-- Bki Tbujhja : !pos -22 0 -60 245
-- Song Runes  : !pos -244 16 -280 118
-----------------------------------
local buburimuID   = zones[xi.zone.BUBURIMU_PENINSULA]
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT)

quest.reward =
{
    item  = xi.item.POETIC_PARCHMENT,
    title = xi.title.RESEARCHER_OF_CLASSICS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.LOWER_JEUNO] =
        {

            ['Mataligeat'] = quest:event(140),

            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(102)
                    else
                        return quest:messageName(lowerJeunoID.text.MERTAIRE_MALLIEBELL_LEFT, 0, 0, 0, 0, true, false)
                    end
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Song_Runes'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.SHEET_OF_PARCHMENT)
                    then
                        return quest:progressCutscene(2)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    if questProgress == 1 then
                        return quest:progressCutscene(0)
                    elseif questProgress == 2 then
                        return quest:messageSpecial(buburimuID.text.SONG_RUNES_REQUIRE, xi.item.SHEET_OF_PARCHMENT)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [2] = function(player, csid, option, npc)
                    player:messageSpecial(buburimuID.text.SONG_RUNES_WRITING, xi.item.SHEET_OF_PARCHMENT)

                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
