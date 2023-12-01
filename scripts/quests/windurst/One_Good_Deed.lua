-----------------------------------
-- Orastery Woes
-- Chipmy-Popmy !gotoid 17760309
-- qm1 !gotoid 16793999
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
local bibikiID = require('scripts/zones/Bibiki_Bay/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONE_GOOD_DEED)

quest.reward =
{
    gil = 3200,
    fame = 50,
    fameArea = xi.quest.fame_area.WINDURST,
    title = xi.title.DEED_VERIFIER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 5
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] = quest:progressEvent(594),

            onEventFinish =
            {
                [594] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        }
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:hasKeyItem(xi.ki.DEED_TO_PURGONORGO_ISLE)
                    then
                        return quest:progressEvent(595, 0, xi.ki.DEED_TO_PURGONORGO_ISLE)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(597) -- Complete Quest
                    end
                end,
            },
            onEventFinish =
            {
                [595] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [597] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },

        },
        [xi.zone.BIBIKI_BAY] =
        {
            ['qm_deed'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.popFromQM(player, npc, bibikiID.mob.PEERIFOOLS, { claim = true, hide = 0 })
                    then
                        return quest:message(bibikiID.text.YOU_ARE_NOT_ALONE)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(34)
                    end
                end,
            },

            ['Peerifool'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onEventFinish =
            {
                -- Killing mobs set prog to 1
                [34] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DEED_TO_PURGONORGO_ISLE)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
        [xi.zone.BONEYARD_GULLY] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 3 then
                        return 8
                    end
                end,
            },

            onEventUpdate =
            {
                [8] = function(player, csid, option, npc)
                    if option == 100 then
                        player:startCutscene(8, 11, xi.ki.DEED_TO_PURGONORGO_ISLE)
                    elseif option == 101 then
                        player:startCutscene(8, 64, 0, xi.ki.DEED_TO_PURGONORGO_ISLE)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if option == 101 or option == 100 then
                        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_THE_ATTOHWA_CHASM)
                        player:delKeyItem(xi.ki.DEED_TO_PURGONORGO_ISLE)
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },
    },
}

return quest
