-----------------------------------
-- Perils of the Griffon
-----------------------------------
-- !addquest 7 37
-- Rholont : !pos -168 -2 56 80
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.PERILS_OF_THE_GRIFFON)

quest.reward =
{
    item  = xi.item.ELIXIR,
    title = xi.title.KNIGHT_OF_THE_SWIFTWING_GRIFFIN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) and
                player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        if
                            quest:getVar(player, 'Timer') <= VanadielUniqueDay() and
                            not quest:getMustZone(player)
                        then
                            return quest:progressEvent(629)
                        else
                            return quest:event(49)
                        end
                    elseif questProgress == 1 then
                        if not quest:getMustZone(player) then
                            return quest:progressEvent(630)
                        else
                            return quest:event(634)
                        end
                    elseif questProgress == 2 then
                        return quest:event(635)
                    elseif questProgress == 3 then
                        return quest:progressEvent(632)
                    end
                end,
            },

            ['Daigraffeaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(631)
                    end
                end,
            },

            onEventFinish =
            {
                [629] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [630] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [631] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [632] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ORCISH_WARMACHINE_BODY) then
                        return quest:event(636)
                    else
                        return quest:progressEvent(633)
                    end
                end,
            },

            onEventFinish =
            {
                [633] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ORCISH_WARMACHINE_BODY) then
                        return quest:progressEvent(210)
                    end
                end,
            },

            onEventFinish =
            {
                [210] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ORCISH_WARMACHINE_BODY)
                end,
            },
        },
    },
}

return quest
