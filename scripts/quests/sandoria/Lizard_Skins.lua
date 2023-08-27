-----------------------------------
-- Lizard Skins
-----------------------------------
-- Log ID: 0, Quest ID: 15
-- Hanaa Punaa : !pos -179.726 -8.8 27.574 230
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LIZARD_SKINS)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    -- Repeatable Items handled within the Trigger:
    -- item = xi.items.LIZARD_GLOVES,
    -- title = xi.title.LIZARD_SKINNER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2 and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_SEAMSTRESS)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hanaa_Punaa'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(559)
                    elseif questProgress == 1 then
                        return quest:progressEvent(562)
                    end
                end,
            },

            onEventFinish =
            {
                [559] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [562] = function(player, csid, option, npc)
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
            ['Hanaa_Punaa'] = quest:progressEvent(560),
        },
    },

    -- These functions check the status of ~= QUEST_AVAILABLE to support repeating
    -- the quest.  Does not have to be flagged again to complete an additional time.
    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hanaa_Punaa'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.LIZARD_SKIN, 3 } }) then
                        return quest:progressEvent(561)
                    end
                end,
            },

            onEventFinish =
            {
                [561] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.LIZARD_GLOVES, { fromTrade = true }) then
                        player:confirmTrade()
                        player:addTitle(xi.title.LIZARD_SKINNER)
                        if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                            quest:complete(player)
                        else
                            player:addFame(xi.quest.fame_area.SANDORIA, 5)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getFameLevel(xi.quest.fame_area.SANDORIA) < 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hanaa_Punaa'] = quest:event(591):replaceDefault()
        },
    },
}

return quest
