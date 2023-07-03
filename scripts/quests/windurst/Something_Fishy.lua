-----------------------------------
-- Something Fishy
-----------------------------------
-- Log ID: 2, Quest ID: 52
-- Tokaka : !pos 240 -189.678 -2 66.335
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)

quest.reward =
{
    fame     = 60,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Tokaka'] = quest:progressEvent(208, 0, xi.items.BASTORE_SARDINE),

            onEventFinish =
            {
                [208] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Dialog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Tokaka'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Dialog') == 1 then
                        return quest:event(209, 0, xi.items.BASTORE_SARDINE)
                    elseif quest:getMustZone(player) then
                        return quest:event(211)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.BASTORE_SARDINE) and
                        quest:getVar(player, 'Dialog') == 1
                    then
                        return quest:event(210, 70, xi.items.BASTORE_SARDINE)
                    end
                end,
            },

            onEventFinish =
            {
                [210] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setMustZone(player)

                    if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_ACCEPTED then
                        quest:complete(player)
                        player:addGil(xi.settings.main.GIL_RATE * 70) -- removed from reward section to here as the text to get gil is in the CS.
                    else
                        player:addFame(xi.quest.fame_area.WINDURST, 10)
                        quest:setVar(player, 'Dialog', 0)
                        player:addGil(xi.settings.main.GIL_RATE * 70)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Tokaka'] =
            {
                onTrigger = function(player, npc)
                    if not quest:getMustZone(player) then
                        return quest:progressEvent(208, 0, xi.items.BASTORE_SARDINE):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [208] = function(player, csid, option, npc)
                    quest:setVar(player, 'Dialog', 1)
                end,
            },
        },
    },
}

return quest
