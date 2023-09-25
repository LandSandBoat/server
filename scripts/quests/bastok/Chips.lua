-----------------------------------
-- Chips
-----------------------------------
-- Log ID: 1, Quest ID: 82
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local metalworksID = require('scripts/zones/Metalworks/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CHIPS)

quest.reward =
{
    item = xi.items.CCB_POLYMER_PUMP,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            (player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.ONE_TO_BE_FEARED or
            (player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.ONE_TO_BE_FEARED and
            player:getCharVar('Mission[6][638]Status') >= 1))
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Ghebi_Damomohe'] = quest:progressEvent(169),

            onEventFinish =
            {
                [169] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, {
                        xi.items.CARMINE_CHIP,
                        xi.items.CYAN_CHIP,
                        xi.items.GRAY_CHIP
                        }) and
                        not player:hasItem(xi.items.CCB_POLYMER_PUMP)
                    then
                        return quest:progressEvent(883)
                    elseif player:hasItem(xi.items.CCB_POLYMER_PUMP) or player:getFreeSlotsCount() == 0 then
                        return quest:messageSpecial(metalworksID.text.FULL_INVENTORY_AFTER_TRADE, xi.items.CCB_POLYMER_PUMP)
                    end
                end,
            },

            onEventFinish =
            {
                [883] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, {
                        xi.items.CARMINE_CHIP,
                        xi.items.CYAN_CHIP,
                        xi.items.GRAY_CHIP
                        }) and
                        not player:hasItem(xi.items.CCB_POLYMER_PUMP)
                    then
                        return quest:progressEvent(884)
                    elseif player:hasItem(xi.items.CCB_POLYMER_PUMP) or player:getFreeSlotsCount() == 0 then
                        return quest:messageSpecial(metalworksID.text.FULL_INVENTORY_AFTER_TRADE, xi.items.CCB_POLYMER_PUMP)
                    end
                end,
            },

            onEventFinish =
            {
                [884] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.CCB_POLYMER_PUMP) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
