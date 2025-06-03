-----------------------------------
-- Distant Loyalties
-----------------------------------
-- Log ID: 0, Quest ID: 74
-----------------------------------
-- !addquest 0 74
-- Southern San 'dOria !zone 230
-- Femitte: !pos -17.7129 2.1000 10.1636
-- Bastok Markets !zone 235
-- Michea: !pos -299.2114 -15.9717 -156.0629
-- Mythril Ingot !giveitem 653
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
            ['Femitte'] =
            {
                onTrigger = quest:progressEvent(663),
            },

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
                    local questProgress = quest:getVar(player, 'Prog')
                    if
                        questProgress == 3 and
                        player:hasKeyItem(xi.ki.MYTHRIL_HEARTS)
                    then
                        return quest:progressEvent(665)
                    end
                end,
            },

            -- Dialogue will repeat until the quest is completed.
            ['Rouva'] = quest:event(664),

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
                        npcUtil.tradeHasExactly(trade, { { xi.item.MYTHRIL_INGOT, 1 } }) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(317)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 0 and
                        player:hasKeyItem(xi.ki.GOLDSMITHING_ORDER)
                    then
                        return quest:progressEvent(315)
                    elseif questProgress == 1 then
                        return quest:event(316) -- Will repeat until the player trades the Myrthil Ingot
                    elseif
                        questProgress == 2 and
                        quest:getMustZone(player)
                    then
                        return quest:event(320) -- Will repeat until the player zones
                    elseif
                        questProgress == 2 and
                        not quest:getMustZone(player)
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
