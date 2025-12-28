-----------------------------------
-- Missionery Moblin
-- Log ID: 4, Quest ID: 103
-- Koblakiq !pos -64.851 21.834 -117.521 11
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MISSIONARY_MOBLIN)

quest.reward =
{
    gil = 4000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:progressCutscene(7),

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] =

            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.SOILED_LETTER) then
                        return quest:progressCutscene(9)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(8)
                end,
            },

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:event(12),
        },
    },
}

return quest
