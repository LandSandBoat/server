-----------------------------------
-- The Call of the Sea
-----------------------------------
-- Log ID: 4, Quest ID: 67
-- Equette       !pos 0 -22 -17
-- Leporaitceau  !pos 74 -24 5
-- Anteurephiaux !pos 74 -24 5
-- ???           !pos
-----------------------------------
require('scripts/globals/moghouse')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CALL_OF_THE_SEA)

quest.reward =
{
    item = xi.items.MEMENTO_MUFFLER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 1) then
                        return quest:progressEvent(170)
                    end
                end,
            },

            ['Leporaitceau'] =
            {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Option', 2) then
                        return quest:progressEvent(171)
                    end
                end,
            },

            ['Anteurephiaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:isVarBitsSet(player, 'Option', 1, 2) then
                        return quest:progressEvent(172)
                    end
                end,
            },

            onEventFinish =
            {
                -- Equette
                [170] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 1)
                end,
                -- Leporaitceau
                [171] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Option', 2)
                end,
                -- Anteurephiaux
                [172] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 0)
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
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 and player:hasKeyItem(xi.ki.WHISPERING_CONCH) then
                        return quest:progressEvent(174)
                    end
                end,
            },

            ['Anteurephiaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 and player:hasKeyItem(xi.ki.WHISPERING_CONCH) then
                        return quest:progressEvent(173)
                    end
                end,
            },

            onEventFinish =
            {
                -- Equette
                [174] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WHISPERING_CONCH)
                    end
                end,
                -- Anteurephiaux
                [173] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['qm_bloody_coffin'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.popFromQM(player, npc, ID.mob.BLOODY_COFFIN, { claim = true, hide = 0 })
                    then
                        return quest:message(ID.text.FOUL_STENCH)
                    elseif quest:getVar(player, 'Prog') == 1 and not player:hasKeyItem(xi.ki.WHISPERING_CONCH) then
                        player:addKeyItem(xi.ki.WHISPERING_CONCH)
                        return quest:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHISPERING_CONCH)
                    end
                end,
            },

            ['Bloody_Coffin'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onEventFinish =
            {
                -- Equette
                [170] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WHISPERING_CONCH)
                    end
                end,
            },
        },
    },
}

return quest
