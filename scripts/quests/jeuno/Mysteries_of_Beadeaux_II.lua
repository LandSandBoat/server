-----------------------------------
-- Mysteries of Beadeaux II
-----------------------------------
-- Log ID: 3, Quest ID: 32
-- Sattal-Mansal : !pos 40 3 -53 245
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MYSTERIES_OF_BEADEAUX_II)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem = xi.ki.BLACK_MATINEE_NECKLACE,
}

quest.sections =
{
    -- This quest is flagged from an event contained in Mysteries of Beadeaux I
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Sattal-Mansal'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.QUADAV_AUGURY_SHELL) then
                        return quest:progressEvent(92)
                    end
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    }
}

return quest
