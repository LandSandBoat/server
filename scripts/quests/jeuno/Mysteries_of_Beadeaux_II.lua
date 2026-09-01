-----------------------------------
-- Mysteries of Beadeaux II
-----------------------------------
-- Log ID: 3, Quest ID: 32
-- Sattal-Mansal : !pos 40 3 -53 245
-----------------------------------
local lowerJeunoID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II)

quest.sections =
{
    -- This quest is flagged from an event contained in Mysteries of Beadeaux I
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
                    if not npcUtil.tradeMatches(trade, { { xi.item.QUADAV_AUGURY_SHELL, 1 } }) then
                        return
                    end

                    player:addKeyItem(xi.ki.BLACK_MATINEE_NECKLACE)
                    player:addFame(xi.fameArea.SANDORIA, 7)
                    player:addFame(xi.fameArea.BASTOK, 7)
                    player:addFame(xi.fameArea.WINDURST, 7)
                    player:tradeComplete()

                    return quest:progressEvent(92)
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II)
                    player:messageSpecial(lowerJeunoID.text.KEYITEM_OBTAINED, xi.ki.BLACK_MATINEE_NECKLACE)
                end,
            },
        },
    },
}

return quest
