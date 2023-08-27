-----------------------------------
-- The Search for Goldmane
-----------------------------------
-- Log ID: 5, Quest ID: 200
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SEARCH_FOR_GOLDMANE)

quest.reward =
{
    fame     = 40,
    fameArea = xi.quest.fame_area.SELBINA_RABAO,
    gil      = 3000,
    title    = xi.title.ROOKIE_HERO_INSTRUCTOR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.CHASING_DREAMS) and
            player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
        end,

        [xi.zone.RABAO] =
        {
            ['Zoriboh'] = quest:progressEvent(123),

            onEventFinish =
            {
                [123] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.CARE_PACKAGE)
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

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Quelveuiat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(396)
                    end
                end,
            },

            onEventFinish =
            {
                [396] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_A01] =
        {
            ['Spatial_Displacement'] =
            {
                onTrigger = function(player, npc)
                    if
                        npc:getID() == 16900356 and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(40)
                    end
                end,
            },

            ['Trunk'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.COPPER_KEY) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(41)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
                [41] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Vladinek'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(887)
                    elseif quest:getVar(player, 'Prog') > 3 then
                        -- Additional Dialogue
                        return quest:event(888)
                    end
                end,
            },

            onEventFinish =
            {
                [887] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['Weathered_Boat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(40)
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(37)
                    end
                end,
            },

            ['Rohemolipaud'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    local mob = ID.mob.ROHEMOLIPAUD
                    if not GetMobByID(mob):isSpawned() then
                        SpawnMob(mob):updateClaim(player)
                    end
                end,

                [37] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.DELUXE_CARBINE)
                    quest:setVar(player, 'Prog', 6)
                end,
            },
        },

        [xi.zone.RABAO] =
        {
            ['Zoriboh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 6 then
                        return quest:progressEvent(128)
                    end
                end,
            },

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
