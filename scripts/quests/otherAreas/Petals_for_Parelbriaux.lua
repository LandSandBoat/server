-----------------------------------
-- Petals for Parelbriaux
-----------------------------------
-- Log ID: 4, Quest ID: 74
-- Parelbriaux : !pos 115 -41 43
-- Chemioue    : !pos 82 -33 67
-- Ondieulix   : !pos 6 -25 65
-- ???         : !pos -210 -15 274
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.PETALS_FOR_PARELBRIAUX)

quest.reward =
{
    item = xi.items.POWERFUL_ROPE,
    title = xi.title.PUTRID_PURVEYOR_OF_PUNGENT_PETALS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.DARKNESS_NAMED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Chemioue'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 1) then
                        return quest:progressEvent(512)
                    end
                end,
            },

            ['Parelbriaux'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 2) then
                        return quest:progressEvent(513)
                    end
                end,
            },

            ['Ondieulix'] =
            {
                onTrigger = function(player, npc)
                    if quest:isVarBitsSet(player, 'Option', 1, 2) then
                        return quest:progressEvent(514)
                    end
                end,
            },

            onEventFinish =
            {
                [512] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 1)
                end,
                [513] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 2)
                end,
                [514] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 0)
                    quest:begin(player)
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Ondieulix'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.PARTICULARLY_POIGNANT_PETAL) then
                        return quest:progressEvent(516)
                    end
                end,
            },

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.PARTICULARLY_POIGNANT_PETAL)
                    end
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            ['qm_baumesel'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        player:getWeather() == xi.weather.FOG and
                        npcUtil.popFromQM(player, npc, ID.mob.BAUMESEL, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(zones[player:getZoneID()].text.SPINE_CHILLING_PRESENCE)

                    elseif quest:getVar(player, 'Prog') == 1 and not player:hasKeyItem(xi.ki.PARTICULARLY_POIGNANT_PETAL) then
                        return quest:progressEvent(115)
                    end
                end,
            },

            ['Baumesel'] =
            {
                onMobDeath = function(mob, player)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [115] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.PARTICULARLY_POIGNANT_PETAL)
                end,
            },
        },
    },
}

return quest
