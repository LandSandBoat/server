-----------------------------------
-- Go! Go! Gobmuffin!
-----------------------------------
-- Log ID: 4, Quest ID: 69
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/Riverne-Site_B01/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.GO_GO_GOBMUFFIN)

quest.reward =
{
    keyItem = xi.ki.MAP_OF_CAPE_RIVERNE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.ANCIENT_VOWS
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Epinolle'] = quest:progressEvent(232),

            onEventFinish =
            {
                [232] = function(player, csid, option, npc)
                    quest:begin(player)
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
            ['Epinolle'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(234)
                    end
                end,
            },

            onEventFinish =
            {
                [234] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_B01] =
        {
            ['Spatial_Displacement'] =
            {
                onTrigger = function(player, npc)
                    if
                        npc:getID() == 16896198 and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(17)
                    end
                end,
            },

            ['Spell_Spitter_Spilospok'] =
            {
                onMobDeath = function(mob, player, optParams)
                    -- This is called for all players in range
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        not GetMobByID(ID.mob.SPILOSPOK):isSpawned() and
                        option == 0
                    then
                        SpawnMob(ID.mob.SPILOSPOK):updateClaim(player)
                        SpawnMob(ID.mob.CHEMACHIQ):updateClaim(player)
                        SpawnMob(ID.mob.BOKABRAQ):updateClaim(player)
                    end
                end,
            },
        },
    },
}

return quest
