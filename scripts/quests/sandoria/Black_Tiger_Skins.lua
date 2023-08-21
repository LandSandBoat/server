-----------------------------------
-- Black Tiger Skins
-----------------------------------
-- Log ID: 0, Quest ID: 31
-- Hanaa Punaa : !pos -179.726 -8.8 27.574 230
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACK_TIGER_SKINS)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.item.TIGER_STOLE,
    itemParams = { fromTrade = true },
    title = xi.title.CAT_SKINNER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3 and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LIZARD_SKINS)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hanaa_Punaa'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(576)
                    elseif questProgress == 1 then
                        return quest:progressEvent(579)
                    end
                end,
            },

            onEventFinish =
            {
                [576] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [579] = function(player, csid, option, npc)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hanaa_Punaa'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.TIGER_HIDE, 3 } }) then
                        return quest:progressEvent(577)
                    end
                end,

                onTrigger = quest:progressEvent(578),
            },

            onEventFinish =
            {
                [577] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hanaa_Punaa'] = quest:event(592):replaceDefault()
        },
    },
}

return quest
