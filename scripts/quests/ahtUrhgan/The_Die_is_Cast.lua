-----------------------------------
-- The Die is Cast
-----------------------------------
-- Log ID: 6, Quest ID: 16
-- Ratihb            !pos 75.225 -6 -137.2 50
-- Ekhu Pesshyadha   !pos -14 1 95 50
-- Jijiroon          !pos 15 0 -32 53
-- qm9               !pos 311 -3.374 170.124 54
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local arrapagoID = require('scripts/zones/Arrapago_Reef/IDs')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_DIE_IS_CAST)

quest.reward =
{
    item = xi.items.RANDOM_RING,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW) ~= QUEST_AVAILABLE -- accepted or complete
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] = quest:progressEvent(591),

            onEventFinish =
            {
                [591] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(593)
                    end
                end,
            },

            ['Ekhu_Pesshyadha'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(592)
                    end
                end,
            },

            onEventFinish =
            {
                [592] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [593] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.BAG_OF_GOLD_PIECES)
                    end
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            ['Jijiroon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(245, 1, 791, 5, 538, 9)
                    end
                end,
            },

            onEventFinish =
            {
                [245] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm9'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(212)
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        npcUtil.popFromQM(player, npc, arrapagoID.mob.BUKKI, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(arrapagoID.text.FEEL_A_CHILL)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(213)
                    end
                end,
            },

            ['Bukki'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },

            onEventFinish =
            {
                [212] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [213] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    npcUtil.giveKeyItem(player, xi.ki.BAG_OF_GOLD_PIECES)
                end,
            },
        },
    },
}

return quest
