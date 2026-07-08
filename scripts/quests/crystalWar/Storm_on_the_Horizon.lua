-----------------------------------
-- Storm on the Horizon
-----------------------------------
-- !addquest 7 35
-- Blatherix    : !pos -310 -12 -43 87
-- Gentle Tiger : !pos -203 -9 0 87
-- Monument     : !pos 300 -63 497 88
-- qm5          : !pos 260 33 515 89
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.STORM_ON_THE_HORIZON)

quest.reward =
{
    item = xi.item.ICARUS_WING,
}

quest.sections =
{
    -- Zone into Bastok Markets [S] from North Gustaberg [S]
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BURDEN_OF_SUSPICION)
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            onZoneIn = function(player, prevZone)
                if
                    quest:getVar(player, 'Prog') == 1 and
                    prevZone == xi.zone.NORTH_GUSTABERG_S and
                    not quest:getMustZone(player) and
                    quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                then
                    return 56
                end
            end,

            ['Blatherix'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(37)
                    else
                        return quest:event(38)
                    end
                end,
            },

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.ELIXIR) then
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                        quest:setMustZone(player)
                    end
                end,

                [56] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Gentle Tiger -> Monument -> Grauberg ??? reward/completion
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

                    if questProgress == 2 then
                        return quest:progressEvent(57)
                    elseif questProgress == 3 then
                        return quest:event(58)
                    end
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            }
        },

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            ['Monument'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.GRAUBERG_S] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(16)
                    end
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
