-----------------------------------
-- Blackmail
-----------------------------------
-- Log ID: 0, Quest ID: 71
-- Dauperiat !gotoid 17723525
-- Halver !gotoid 17731591
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 900,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3 -- Rank 3 for home nation is assumed to get into Chateau... no need to check for it
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Dauperiat']  = quest:progressEvent(643),

            onEventFinish =
            {
                [643] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.SUSPICIOUS_ENVELOPE)
                end,
            },
        },
    },

    -- These functions check the status of ~= QUEST_AVAILABLE to support repeating
    -- the quest.  Does not have to be flagged again to complete an additional time.
    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Dauperiat'] =
            {
                onTrade = function(player, npc, trade)
                    if
                    npcUtil.tradeHasExactly(trade, { { xi.items.CASTLE_FLOOR_PLANS, 1 } }) and
                    quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(648, 0, xi.items.CASTLE_FLOOR_PLANS)
                    end
                end,

                onTrigger = function(player, npc)
                    print(quest:getVar(player, 'Prog'))
                    if player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE) then
                        return quest:event(645)

                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(646, 0, xi.items.CASTLE_FLOOR_PLANS)

                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(647, 0, xi.items.CASTLE_FLOOR_PLANS)

                    elseif player:hasCompletedQuest(quest.areaId, quest.questId) then
                        return quest:progressEvent(650, 0, xi.items.CASTLE_FLOOR_PLANS)
                    end
                end,
            },

            onEventFinish =
            {
                [646] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [648] = function(player, csid, option, npc)
                    if player:hasCompletedQuest(quest.areaId, quest.questId) then
                        quest.fame = 5
                    end

                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [650] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                        quest:begin(player)
                    end
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE) then
                        return quest:progressEvent(549)
                    end
                end,
            },

            onEventFinish =
            {
                [549] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:delKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
                end,
            },
        },
    },
}

return quest
