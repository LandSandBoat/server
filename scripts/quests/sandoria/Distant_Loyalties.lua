-----------------------------------
-- Distant Loyalties
-----------------------------------
-- !addquest 0 74
-- Femitte: !gotoid 17719491
-- Michea: !gotoid 17739820
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.DISTANT_LOYALTIES)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.SANDORIA,
    item     = xi.item.WHITE_CAPE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 4
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Femitte'] = quest:progressEvent(663),

            onEventFinish =
            {
                [663] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.GOLDSMITHING_ORDER)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Femitte'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.GOLDSMITHING_ORDER) then
                        return quest:event(661)
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        player:hasKeyItem(xi.ki.MYTHRIL_HEARTS)
                    then
                        return quest:progressEvent(665)
                    end
                end,
            },
            ['Rouva'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.GOLDSMITHING_ORDER) then
                        return quest:event(664)
                    end
                end,
            },

            onEventFinish =
            {
                [665] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'finalCS', 1)
                        player:delKeyItem(xi.ki.MYTHRIL_HEARTS)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.MYTHRIL_INGOT) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(317)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if player:hasKeyItem(xi.ki.GOLDSMITHING_ORDER) then
                        return quest:progressEvent(315)
                    elseif questProgress == 1 then
                        return quest:event(316)
                    elseif
                        questProgress == 2 and
                        not player:needToZone()
                    then
                        return quest:progressEvent(318)
                    end
                end,
            },

            onEventFinish =
            {
                [315] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.GOLDSMITHING_ORDER)
                    quest:setVar(player, 'Prog', 1)
                end,

                [317] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 2)
                    quest:setMustZone(player)
                end,

                [318] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.MYTHRIL_HEARTS)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'finalCS') == 1 then
                        return quest:progressEvent(319)
                    end
                end,
            },

            onEventFinish =
            {
                [319] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.GOLDSMITHING_ORDER)
                    quest:setVar(player, 'finalCS', 0)
                end,
            },
        },
    },
}

return quest
