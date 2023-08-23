-----------------------------------
-- A Certain Substitute Patrolman
-----------------------------------
-- !addquest 9 76
-- Rising Solstice : !pos -154 4 -29 256
-- Zaoso           : !pos -94 3 -11 256
-- Clemmar         : !pos -12 0 12 256
-- Kongramm        : !pos 61 32 138 256
-- Virsaint        : !pos 32 0 -5 256
-- Shipilolo       : !pos 84 0 -60 256
-- Dangueubert     : !pos 5 0 -136 256
-- Nylene          : !pos 12 0 -82 256
-----------------------------------
local westernAdoulinID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)

quest.reward =
{
    fameArea = xi.quest.fame_area.ADOULIN,
    xp       = 1000,
    bayld    = 500,
}

local patrolData =
{
    ['Zaoso']       = 0,
    ['Clemmar']     = 1,
    ['Kongramm']    = 2,
    ['Virsaint']    = 3,
    ['Shipilolo']   = 4,
    ['Dangueubert'] = 5,
    ['Nylene']      = 6,
}

local patrolOnTrigger = function(player, npc)
    local npcOffset = patrolData[npc:getName()]

    if quest:getVar(player, 'Prog') == npcOffset then
        return quest:progressEvent(2553 + npcOffset)
    end
end

local patrolOnEventFinish = function(player, csid, option, npc)
    local npcOffset = patrolData[npc:getName()]

    if quest:getVar(player, 'Prog') == npcOffset then
        quest:incrementVar(player, 'Prog', 1)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.SOA) >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Rising_Solstice'] = quest:progressEvent(2550),

            onEventFinish =
            {
                [2550] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.WESTERN_ADOULIN_PATROL_ROUTE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Rising_Solstice'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 7 then
                        return quest:progressEvent(2552)
                    else
                        return quest:event(2551)
                    end
                end,
            },

            ['Zaoso'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Clemmar'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Kongramm'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Virsaint'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Shipilolo'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Dangueubert'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Nylene'] =
            {
                onTrigger = patrolOnTrigger,
            },

            onEventFinish =
            {
                [2552] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WESTERN_ADOULIN_PATROL_ROUTE)
                        player:messageSpecial(westernAdoulinID.text.KEYITEM_LOST, xi.ki.WESTERN_ADOULIN_PATROL_ROUTE)
                    end
                end,

                [2553] = patrolOnEventFinish,
                [2554] = patrolOnEventFinish,
                [2555] = patrolOnEventFinish,
                [2556] = patrolOnEventFinish,
                [2557] = patrolOnEventFinish,
                [2558] = patrolOnEventFinish,
                [2559] = patrolOnEventFinish,
            },
        },
    },
}

return quest
