-----------------------------------
-- The Usual
-----------------------------------
-- Log ID: 1, Quest ID: 27
-- Hilda   : !pos -163 -8 13 236
-- Raibaht : !pos -27 -10 -1 237
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_USUAL)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.SPEED_BOW,
    title    = xi.title.STEAMING_SHEEP_REGULAR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CIDS_SECRET) and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 5
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Hilda'] = quest:progressEvent(134),

            onEventFinish =
            {
                [134] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Hilda'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.KING_TRUFFLE) and
                        not player:hasKeyItem(xi.ki.STEAMING_SHEEP_INVITATION)
                    then
                        return quest:progressEvent(135)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(136)
                    end
                end,
            },

            onEventFinish =
            {
                [135] = function(player, csid, option, npc)
                    player:confirmTrade()

                    npcUtil.giveKeyItem(player, xi.ki.STEAMING_SHEEP_INVITATION)
                end,

                [136] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.STEAMING_SHEEP_INVITATION)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Raibaht'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.STEAMING_SHEEP_INVITATION) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(510)
                    end
                end,
            },

            onEventFinish =
            {
                [510] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
