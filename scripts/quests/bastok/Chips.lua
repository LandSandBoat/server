-----------------------------------
-- Chips
-----------------------------------
-- Log ID: 1, Quest ID: 82
-- NPC: Ghebi Damomohe !pos 17.05 -0.11 -5.53 245
-- NPC: Cid !pos -12.53 -10.98 1.09 237
-----------------------------------
local metalworksID = zones[xi.zone.METALWORKS]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.CHIPS)

local chips =
{
    xi.item.CARMINE_CHIP,
    xi.item.CYAN_CHIP,
    xi.item.GRAY_CHIP,
}

quest.reward =
{
    item = xi.item.CCB_POLYMER_PUMP,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            (player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.ONE_TO_BE_FEARED or
            xi.mission.getVar(player, xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED, 'Status') == 1) and
            not quest:getMustZone(player)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Ghebi_Damomohe'] = quest:progressEvent(169),

            onEventFinish =
            {
                [169] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    else
                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, chips) and
                        not player:hasItem(xi.item.CCB_POLYMER_PUMP)
                    then
                        return quest:progressEvent(883)
                    elseif
                        player:hasItem(xi.item.CCB_POLYMER_PUMP) or
                        player:getFreeSlotsCount() == 0
                    then
                        return quest:messageSpecial(metalworksID.text.FULL_INVENTORY_AFTER_TRADE, xi.item.CCB_POLYMER_PUMP)
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
            return status == xi.questStatus.QUEST_COMPLETED -- You must zone if dropped as it will be in recycle bin and not allow you get get another.
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, chips) and
                        not player:hasItem(xi.item.CCB_POLYMER_PUMP)
                    then
                        return quest:progressEvent(884)
                    elseif
                        player:hasItem(xi.item.CCB_POLYMER_PUMP) or
                        player:getFreeSlotsCount() == 0
                    then
                        return quest:messageSpecial(metalworksID.text.FULL_INVENTORY_AFTER_TRADE, xi.item.CCB_POLYMER_PUMP)
                    end
                end,
            },

            onEventFinish =
            {
                [884] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CCB_POLYMER_PUMP) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
