-----------------------------------
-- A Minstrel in Despair
-----------------------------------
-- Log ID: 3, Quest ID: 12
-- Mertaire : !pos -17 0 -61 245
-----------------------------------
local buburimuID   = zones[xi.zone.BUBURIMU_PENINSULA]
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    gil      = 2100,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT) == xi.questStatus.QUEST_COMPLETED
        end,

        -- Failsafe incase the player loses their Poetic Parchment
        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Song_Runes'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SHEET_OF_PARCHMENT) then
                        return quest:progressCutscene(2)
                    end
                end,

                onTrigger = quest:messageSpecial(buburimuID.text.SONG_RUNES_REQUIRE, xi.item.SHEET_OF_PARCHMENT),
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveItem(player, xi.item.POETIC_PARCHMENT)
                    player:messageSpecial(buburimuID.text.SONG_RUNES_WRITING, xi.item.SHEET_OF_PARCHMENT)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {

            ['Bki_Tbujhja'] = quest:event(182),

            ['Mataligeat'] = quest:event(144),

            ['Mertaire'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { xi.item.POETIC_PARCHMENT }) then
                        return quest:progressEvent(101)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:messageName(lowerJeunoID.text.MERTAIRE_MALLIEBELL_LEFT, 0, 0, 0, 0, true, false)
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            }
        },
    },
}

return quest
