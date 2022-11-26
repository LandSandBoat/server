-----------------------------------
-- The Longest Way Round...
-----------------------------------
-- !addquest 9 91
-- Vastran        : !pos -118.93 -0.15 -8.813 257
-- Fostaig        : !pos -84.806 -0.15 14.079 257
-- Lamaron        : !pos -52.352 -0.65 96.708 257
-- Irate Destrier : !pos -72.986 -0.15 -34.96 257
-- Nhili Uvolep   : !pos 24.06 -22.15 34.488 257
-- Ploh Trishbahk : !pos 100.58 -40.15 -63.83 257
-- Cunegonde      : !pos -55.964 -0.15 -129.833 257
-- Ndah Tolohjin  : !pos -86.808 0.001 -36.867 257
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local easternAdoulinID = require('scripts/zones/Eastern_Adoulin/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.THE_LONGEST_WAY_ROUND)

quest.reward =
{
    fameArea = xi.quest.fame_area.ADOULIN,
    xp       = 1000,
    bayld    = 500,
}

local patrolData =
{
    ['Fostaig']        = 0,
    ['Lamaron']        = 1,
    ['Irate_Destrier'] = 2,
    ['Nhili_Uvolep']   = 3,
    ['Ploh_Trishbahk'] = 4,
    ['Cunegonde']      = 5,
    ['Ndah_Tolohjin']  = 6,
}

local patrolOnTrigger = function(player, npc)
    local npcOffset = patrolData[npc:getName()]

    if quest:getVar(player, 'Prog') == npcOffset then
        return quest:progressEvent(2513 + npcOffset)
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

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Vastran'] = quest:progressEvent(2510),

            onEventFinish =
            {
                [2510] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.EASTERN_ADOULIN_PATROL_ROUTE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Vastran'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 7 then
                        return quest:progressEvent(2512)
                    else
                        return quest:event(2511)
                    end
                end,
            },

            ['Fostaig'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Lamaron'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Irate_Destrier'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Nhili_Uvolep'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Ploh_Trishbahk'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Cunegonde'] =
            {
                onTrigger = patrolOnTrigger,
            },

            ['Ndah_Tolohjin'] =
            {
                onTrigger = patrolOnTrigger,
            },

            onEventFinish =
            {
                [2512] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.EASTERN_ADOULIN_PATROL_ROUTE)
                        player:messageSpecial(easternAdoulinID.text.KEYITEM_LOST, xi.ki.EASTERN_ADOULIN_PATROL_ROUTE)
                    end
                end,

                [2513] = patrolOnEventFinish,
                [2514] = patrolOnEventFinish,
                [2515] = patrolOnEventFinish,
                [2516] = patrolOnEventFinish,
                [2517] = patrolOnEventFinish,
                [2518] = patrolOnEventFinish,
                [2519] = patrolOnEventFinish,
            },
        },
    },
}

return quest
