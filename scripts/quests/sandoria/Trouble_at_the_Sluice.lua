-----------------------------------
-- Trouble at the Sluice
-----------------------------------
-- Log ID: 0, Quest ID: 68
-----------------------------------
-- Belgidiveau : !pos -98 0 69 231
-- Novalmauge  : !pos 70 -24 21 167
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)

quest.reward =
{
    item = xi.item.HEAVY_AXE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RUMOR) == xi.questStatus.QUEST_COMPLETED and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 3
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Belgidiveau'] = quest:progressEvent(57),

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                not player:hasKeyItem(xi.ki.NEUTRALIZER) and
                vars.Prog == 0
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Belgidiveau'] = quest:event(55),
        },

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] = quest:progressEvent(15),

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                not player:hasKeyItem(xi.ki.NEUTRALIZER) and
                vars.Prog == 1
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Belgidiveau'] = quest:event(55),
        },

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.DAHLIA) then
                        return quest:progressEvent(17)
                    end
                end,

                onTrigger = quest:event(16),
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.NEUTRALIZER) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.NEUTRALIZER)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Belgidiveau'] = quest:progressEvent(56),

            onEventFinish =
            {
                [56] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.NEUTRALIZER)
                    end
                end,
            },
        },
    },
}

return quest
