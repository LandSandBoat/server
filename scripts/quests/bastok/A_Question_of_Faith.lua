-----------------------------------
-- A Question of Faith
-----------------------------------
-- Area: Metalworks
--  NPC: Ayame
--  !pos 133 -18 33
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_QUESTION_OF_FAITH)

quest.reward =
{
    gil = 3000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.BASTOK) >= 4 and
            player:hasCompletedQuest(xi.quest.id.bastok.OUT_OF_THE_DEPTHS)
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] = quest:progressEvent(875),

            onEventFinish =
            {
                [875] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },

    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Virnage'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.DAWN_TALISMAN) and quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(239)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(241)
                    end
                end,
            },

            onEventFinish =
            {
                [239] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.DAWN_TALISMAN)
                    end
                end,

                [241] = function(player, csid, option, npc)
                    if option == 0 then
                        player:addFame(xi.quest.fame_area.BASTOK, 50)
                        quest:complete(player)
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Rakorok'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.DAWN_TALISMAN) and quest.getVar(player, 'Prog') == 0 then
                        npc:messageText(npc, 7733)
                        npc:messageText(npc, 7746)
                        SpawnMob(16822456):updateClaim(player)
                    elseif not GetMobByID(16822456):isAlive() then
                        return quest:progressEvent(6, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.DAWN_TALISMAN)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
