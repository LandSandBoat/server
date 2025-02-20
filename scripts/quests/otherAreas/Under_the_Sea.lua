-----------------------------------
-- Under the Sea
-----------------------------------
-- Log ID: 4, Quest ID: 17
-- !addquest 4 17
-- Yaya    : !pos -18.770 -2.597 -14.929 248
-- Oswald  : !pos 47.119 -15.273 7.989 248
-- Jimaida : !pos -17.342 -2.597 -18.766 248
-- Zaldon  : !pos -11.810 -7.287 -6.742 248
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA)

quest.reward =
{
    item     = xi.item.AMBER_EARRING,
    title    = xi.title.LIL_CUPID,
    fameArea = xi.fameArea.SELBINA_RABAO,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 2 and
                xi.settings.map.FISHING_ENABLE == true
        end,

        [xi.zone.SELBINA] =
        {
            ['Yaya'] = quest:progressEvent(31),

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
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(32) -- Oswald is looking for his ring
                    elseif player:hasKeyItem(xi.ki.ETCHED_RING) then
                        return quest:progressEvent(37) -- You found it!
                    end
                end,
            },

            ['Jimaida'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(33) -- Go see Zaldon
                    end
                end,
            },

            ['Zaldon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(34, xi.item.FAT_GREEDIE)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        npcUtil.tradeHasExactly(trade, xi.item.FAT_GREEDIE)
                    then
                        if math.random(1, 100) <= 20 then
                            return quest:progressEvent(35) -- Ring found !
                        else
                            return quest:event(36) -- Ring not found
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [33] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [34] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [35] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.ETCHED_RING)
                    quest:setVar(player, 'Prog', 4)
                end,

                [36] = function(player, csid, option, npc)
                    player:confirmTrade()
                end,

                [37] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ETCHED_RING)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:event(38):replaceDefault(),
        },
    },
}

return quest
