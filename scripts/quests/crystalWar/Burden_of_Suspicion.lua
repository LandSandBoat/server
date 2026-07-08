-----------------------------------
-- Burden of Suspicion
-----------------------------------
-- !addquest 7 20
-- Gentle Tiger : !pos -203 -9 0 87
-- Engelhart    : !pos -79 -4 -123 87
-- Sarcophagus  : !pos 346 -32 -125 175
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BURDEN_OF_SUSPICION)

quest.reward =
{
    title = xi.title.ASSISTANT_DETECTIVE,
}

quest.sections =
{
    -- Talk to Gentle Tiger in Bastok Markets (S)
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS)
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return quest:progressEvent(30)
                    end
                end,
            },

            onEventFinish =
            {
                [30] = function(player, csid, option, npc)
                    quest:begin(player)
                    player:delKeyItem(xi.ki.WARNING_LETTER)
                end,
            },
        },
    },

    -- Continue the investigation in Bastok Markets (S) and The Eldieme Necropolis [S]
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:event(28) -- Retail accurate, but odd.
                    elseif questProgress == 2 then
                        return quest:progressEvent(34)
                    else
                        return quest:event(31)
                    end
                end,
            },

            ['Engelhart'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(32)
                    elseif questProgress == 2 then
                        return quest:event(36)
                    else
                        return quest:event(33)
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [34] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Sarcophagus'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(17)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },
}

return quest
