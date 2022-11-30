-----------------------------------
-- Rock Bottom
-- !pos 838.243 -14.475 231.871 61
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.ROCK_BOTTOM)

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['blank11'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(7)
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['blank11'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, xi.items.PICKAXE)
                    then
                        return quest:progressEvent(8)
                    elseif
                        not player:needToZone() and
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHas(trade, { xi.items.MYTHRIL_PICK, xi.items.MYTHRIL_PICK_HQ }, true, true)
                    then
                        return quest:progressEvent(9, { [0] = trade:getItemId() })
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_HAPPENS)
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:needToZone(true)
                end,

                [9] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_MOUNT_ZHAYOLM)
                    end
                end,
            },
        },
    },
}

return quest
