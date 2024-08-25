-----------------------------------
-- Making Amens!
-----------------------------------
-- Log ID: 2, Quest ID: 8
-- Kuroido-Moido   : !pos -111 -4 101 240
-- Hakkuru-Rinkuru : !pos -111 -4 101 240
-- Mashira         : !pos 141 -6 138 200
-- Crematory Hatch : !pos 139 -6 127 200
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENS)

quest.reward =
{
    fame     = 150,
    fameArea = xi.fameArea.WINDURST,
    gil      = 6000,
    title    = xi.title.HAKKURU_RINKURUS_BENEFACTOR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS) and
                player:getFameLevel(xi.fameArea.WINDURST) >= 4 and
                not quest:getMustZone(player)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] = quest:progressEvent(280),

            onEventFinish =
            {
                [280] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                not player:hasKeyItem(xi.ki.BROKEN_WAND)
        end,

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['Mashira'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') ~= 0 then
                        return quest:progressEvent(11, 2) -- player must have opened the Crematory Hatch or Mashira does not provide Broken Wand option
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                -- Mashira
                [11] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.BROKEN_WAND)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:event(282):replaceDefault(),

            ['Kuroido-Moido'] = quest:event(283):replaceDefault(),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.BROKEN_WAND)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:event(282):replaceDefault(),

            ['Kuroido-Moido'] = quest:progressEvent(284),

            onEventFinish =
            {
                [284] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:needToZone(true)
                        player:delKeyItem(xi.ki.BROKEN_WAND)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:event(285, 0, xi.ki.BROKEN_WAND):importantOnce(),

            ['Kuroido-Moido'] = quest:event(286, 0, xi.item.BLOCK_OF_ANIMAL_GLUE):importantOnce(),
        },
    },
}

return quest
