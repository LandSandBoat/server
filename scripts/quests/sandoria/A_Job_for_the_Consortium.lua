-----------------------------------
-- A Job for the Consortium
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
----------------------------------
local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_JOB_FOR_THE_CONSORTIUM)

quest.reward =
{
    gil = 1000,
    fame = 25,
    fameArea = xi.quest.fame_area.NORG,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM) == QUEST_COMPLETED and
                player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 5
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Portaure'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Stage') < os.time() then
                        return quest:progressEvent(651)
                    else
                        return quest:message(ID.text.LAY_LOW)
                    end
                end,
            },

            onEventFinish =
            {
                [651] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Reset prog to 0 as delQuest doesn't reset vars
                        quest:setVar(player, 'Prog', 0)
                        npcUtil.giveKeyItem(player, xi.ki.BRUGAIRE_GOODS)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Portaure'] =
            {
                onTrigger = function(player, npc)
                    -- Tell players to go at night
                    if player:hasKeyItem(xi.ki.BRUGAIRE_GOODS) then
                        return quest:event(652)

                    -- Player was caught (Delete quest)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(654)

                    -- Player was successful (Complete quest)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(653)
                    end
                end,
            },

            onEventFinish =
            {
                [654] = function(player, csid, option, npc)
                    player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_JOB_FOR_THE_CONSORTIUM)
                end,
                [653] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Haubijoux'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.BRUGAIRE_GOODS) then
                        if math.random() > 0.25 or (VanadielHour() < 6 or VanadielHour() > 18) then
                            quest:setVar(player, 'Option', 0)
                            return quest:progressEvent(54)
                        else
                            quest:setVar(player, 'Option', 1)
                            return quest:progressEvent(54, 1)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [54] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        player:delKeyItem(xi.ki.BRUGAIRE_GOODS)
                        quest:setVar(player, 'Stage', getMidnight())
                    else
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Yin_Pocanakhu'] =
            {
                onTrigger = function(player, npc)
                    -- Player correctly brought the package
                    if player:hasKeyItem(xi.ki.BRUGAIRE_GOODS) and quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(219)

                    -- Player didn't go through airship terminal. Package is broken!
                    elseif quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(218)
                    end
                end,
            },

            onEventFinish =
            {
                [219] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.BRUGAIRE_GOODS)
                    quest:setVar(player, 'Prog', 3)
                end,
                [218] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.BRUGAIRE_GOODS)
                    player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_JOB_FOR_THE_CONSORTIUM)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                quest:getVar(player, 'Stage') < os.time()
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Portaure'] = quest:progressEvent(651),

            onEventFinish =
            {
                [651] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_JOB_FOR_THE_CONSORTIUM)
                        npcUtil.giveKeyItem(player, xi.ki.BRUGAIRE_GOODS)
                        quest:begin(player)
                    end
                end,
            },
        },
    },
}

return quest
