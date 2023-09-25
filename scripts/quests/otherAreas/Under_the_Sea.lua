-----------------------------------
-- Under the Sea
-----------------------------------
-- Log ID: 4, Quest ID: 17
-- Yaya    : !pos -18.770 -2.597 -14.929 248
-- Oswald  : !pos 47.119 -15.273 7.989 248
-- Jimaida : !pos -17.342 -2.597 -18.766 248
-- Zaldon  : !pos -11.810 -7.287 -6.742
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA)

quest.reward =
{
    item = xi.items.AMBER_EARRING,
    title = xi.title.LIL_CUPID
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 2
        end,

        [xi.zone.SELBINA] =
        {
            ['Yaya'] =
            {
                onTrigger = quest:event(31)
            },

            onEventFinish =
            {
                [31] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ETCHED_RING) then
                        return quest:event(37)
                    elseif quest:getVar(player, "status") == 0 then
                        return quest:event(32)
                    end
                end,
            },
            ['Jimaida'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, "status") == 1 then
                        return quest:event(33)
                    end
                end,
            },
            ['Zaldon'] =
            {
                onTrade = function(player, npc, trade)
                    if not player:hasKeyItem(xi.ki.ETCHED_RING) and
                    npcUtil.tradeHas(trade, xi.items.FAT_GREEDIE) and
                    quest:getVar(player, 'status') == 3 then
                        if math.random(100) <= 20 then
                            player:startEvent(35) -- Ring found!
                        else
                            player:startEvent(36) -- Ring not found
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'status') == 2 then
                        return quest:event(34, xi.items.FAT_GREEDIE)
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    quest:incrementVar(player, "status", 1)
                end,

                [33] = function(player, csid, option, npc)
                    quest:incrementVar(player, "status", 1)
                end,

                [34] = function(player, csid, option, npc)
                    quest:incrementVar(player, "status", 1)
                end,

                [35] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ETCHED_RING)
                    player:confirmTrade()
                end,

                [36] = function(player, csid, option, npc)
                    player:confirmTrade()
                end,

                [37] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ETCHED_RING)
                    quest:complete(player)
                end,
            },
        },
    },
    {
        {
            check = function(player, status, vars)
                return status == QUEST_COMPLETED and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) == QUEST_AVAILABLE
            end,

            [xi.zone.SELBINA] =
            {
                ['Oswald'] = quest:event(38):replaceDefault(),
            },
        },
    },
}

return quest
