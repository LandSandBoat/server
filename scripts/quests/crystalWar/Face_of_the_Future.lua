-----------------------------------
-- Face of the Future
-----------------------------------
-- !addquest 7 61
-- Metallic Hodgepodge : !pos -285.493 -7.819 -163.707 104
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.FACE_OF_THE_FUTURE)

quest.reward =
{
    item  = xi.item.GRIFFON_RING,
    title = xi.title.FANGMONGER_FORESTALLER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.JUGNER_FOREST] =
        {
            ['Metallic_Hodgepodge'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(45)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.BATALLIA_DOWNS and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return 44
                    end
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [45] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.GHELSBA_OUTPOST] =
        {
            ['Clandestine_Marking'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ORCISH_INFILTRATION_KIT) then
                        return quest:keyItem(xi.ki.ORCISH_INFILTRATION_KIT)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 2 then
                        return 57
                    end
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.YUGHOTT_GROTTO] =
        {
            ['Scrape_Mark'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: Progress of 4 is required for instance entry.  Followup event to
                    -- register for the instance is Event 103, Params: 0, 0, 61

                    if quest:getVar(player , 'Prog') == 3 then
                        return quest:progressEvent(1)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                    player:setPos(13.29, -0.104, -59.417, 253, xi.zone.GHELSBA_OUTPOST)
                end,
            },
        },

        [xi.zone.EVERBLOOM_HOLLOW] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:setPos(-184.678, -0.266, -112.093, 101, xi.zone.YUGHOTT_GROTTO)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    if
                        xi.maws.hasUnlockedMaw(player, xi.zone.BATALLIA_DOWNS) and
                        quest:getVar(player, 'Prog') == 6
                    then
                        return quest:progressEvent(504)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 7 then
                        return 505
                    elseif questProgress == 9 then
                        return 508
                    elseif questProgress == 10 then
                        return 507
                    end
                end,
            },

            onEventFinish =
            {
                [504] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                    player:setPos(-47.108, 0.153, 437.1, 65, xi.zone.BATALLIA_DOWNS)
                end,

                [505] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 8)

                    -- TODO: This location is assumed from previous captures, and is most likely
                    -- not accurate.  While sufficient to proceed, this needs to be updated.
                    player:setPos(-105.798, -25.522, -53.499, 176, xi.zone.XARCABARD_S)
                end,

                [507] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setPos(-49.368, 0.268, 436.691, 252, xi.zone.BATALLIA_DOWNS_S)
                    end
                end,

                [508] = function(player, csid, option, npc)
                    -- TODO: This location is assumed from previous captures, and is most likely
                    -- not accurate.  While sufficient to proceed, this needs to be updated.

                    quest:setVar(player, 'Prog', 10)
                    player:setPos(-47.108, 0.154, 437.1, 65, xi.zone.BATALLIA_DOWNS)
                end,
            },
        },

        [xi.zone.XARCABARD_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 8 then
                        return 40
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 9)
                    player:setPos(-47.108, 0.154, 437.1, 65, xi.zone.BATALLIA_DOWNS)
                end,
            },
        },
    },
}

return quest
