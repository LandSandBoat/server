-----------------------------------
-- Mysteries of Beadeaux I
-----------------------------------
-- Log ID: 3, Quest ID: 31
-- Sattal-Mansal : !pos 40 3 -53 245
-----------------------------------
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_I)

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasKeyItem(xi.ki.SILVER_BELL)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Sattal-Mansal'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(89, 0)
                end,
            },

            onEventFinish =
            {
                -- This event flags both Mysteries of Beadeaux I and II
                [89] = function(player, csid, option, npc)
                    quest:begin(player)
                    player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Sattal-Mansal'] =
            {
                -- Retail hands over the reward as the event starts. The message prints when it ends.
                onTrade = function(player, npc, trade)
                    if not npcUtil.tradeMatches(trade, { { xi.item.QUADAV_CHARM, 1 } }) then
                        return
                    end

                    player:addKeyItem(xi.ki.CORUSCANT_ROSARY)
                    player:addFame(xi.fameArea.SANDORIA, 7)
                    player:addFame(xi.fameArea.BASTOK, 7)
                    player:addFame(xi.fameArea.WINDURST, 7)
                    player:tradeComplete()

                    return quest:progressEvent(91)
                end,

                -- Param 0 flags the offer as already taken.
                onTrigger = quest:event(89, 1),
            },

            onEventFinish =
            {
                [91] = function(player, csid, option, npc)
                    player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_I)
                    player:messageSpecial(lowerJeunoID.text.KEYITEM_OBTAINED, xi.ki.CORUSCANT_ROSARY)
                end,
            },
        },
    },
}

return quest
