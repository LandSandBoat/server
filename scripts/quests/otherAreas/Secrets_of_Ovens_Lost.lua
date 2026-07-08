-----------------------------------
-- Spice Gals
-----------------------------------
-- Log ID: 4, Quest ID: 73
-----------------------------------
-- Despachiaire !pos 111.209 -40.015 -85.481
-- Jonette      !pos -70.889 -11.212 9.954
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.SECRETS_OF_OVENS_LOST)

quest.reward =
{
    item = xi.item.MIRATETES_MEMOIRS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return vars.Wait < NextConquestTally() and
                vars.Prog == 0 and
                player:hasCompletedQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.SPICE_GALS)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.SECRETS_OF_OVENS_LOST) == xi.questStatus.QUEST_AVAILABLE and
                        quest:getVar(player, 'Option') == 0
                    then
                        return quest:progressEvent(505)
                    end
                end,
            },

            ['Jonette'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:progressEvent(506)
                    elseif player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.SECRETS_OF_OVENS_LOST) == xi.questStatus.QUEST_COMPLETED then
                        return quest:progressEvent(507) -- Repeat after conquest tally
                    end
                end,
            },

            onEventFinish =
            {
                [505] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [506] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,

                [507] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog == 1
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Jonette'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TAVNAZIAN_COOKBOOK) then
                        return quest:progressEvent(508)
                    end
                end,
            },

            onEventFinish =
            {
                [508] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TAVNAZIAN_COOKBOOK)
                        quest:setVar(player, 'Wait', NextConquestTally())
                    end
                end,
            },
        },

        [xi.zone.SACRARIUM] =
        {
            ['qm_tavnazian_cookbook'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TAVNAZIAN_COOKBOOK) then
                        return quest:keyItem(xi.ki.TAVNAZIAN_COOKBOOK)
                    end
                end,
            },
        },

        [xi.zone.PHOMIUNA_AQUEDUCTS] =
        {
            ['qm_tavnazian_cookbook'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TAVNAZIAN_COOKBOOK) then
                        return quest:keyItem(xi.ki.TAVNAZIAN_COOKBOOK)
                    end
                end,
            },
        },
    },
}

return quest
