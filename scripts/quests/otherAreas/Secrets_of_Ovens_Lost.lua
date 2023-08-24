-----------------------------------
-- Secrets of Ovens Lost
-- Despachiaire: !pos 109 -40 -86
-- Jonette: !pos -71 -11 9
-- Phomiuna Aqueducts qm_tavnazian_cookbook: !pos varies   ID: 16888123
-- Sacrarium qm_tavnazian_cookbook: !pos varies   ID: 16892184
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
local ID = require('scripts/zones/Sacrarium/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.SECRETS_OF_OVENS_LOST)

quest.reward =
{
    item = xi.items.MIRATETES_MEMOIRS,
}

quest.sections =
{
    {
        -- Pre Quest CS with Despachiaire
        check = function(player, status, vars)
            return
                status == QUEST_AVAILABLE and
                quest:getVar(player, 'Prog') == 0 and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SPICE_GALS) == QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(505),

            onEventFinish =
            {
                [505] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
    {
        -- Initial Quest Start with Jonette
        check = function(player, status, vars)
            return
                status == QUEST_AVAILABLE and
                quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Jonette'] = quest:progressEvent(506),

            onEventFinish =
            {
                [506] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        -- Mid Quest, reused for the repeat as well
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Jonette'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TAVNAZIAN_COOKBOOK) then
                        return quest:progressEvent(508)
                    end
                end,
            },

            onEventFinish =
            {
                [508] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TAVNAZIAN_COOKBOOK)
                        quest:setVar(player, 'Option', getConquestTally())
                    end
                end,
            },
        },
        [xi.zone.PHOMIUNA_AQUEDUCTS] =
        {
            ['qm_tavnazian_cookbook'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TAVNAZIAN_COOKBOOK) then
                        player:addKeyItem(xi.ki.TAVNAZIAN_COOKBOOK)
                        return quest:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TAVNAZIAN_COOKBOOK)
                    end
                end,
            },
        },

        [xi.zone.SACRARIUM] =
        {
            ['qm_tavnazian_cookbook'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TAVNAZIAN_COOKBOOK) then
                        player:addKeyItem(xi.ki.TAVNAZIAN_COOKBOOK)
                        return quest:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TAVNAZIAN_COOKBOOK)
                    end
                end,
            },
        },
    },
    {
        -- Quest Repeat
        check = function(player, status, vars)
            return
                status == QUEST_COMPLETED and
                quest:getVar(player, 'Option') < getConquestTally()
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Jonette'] = quest:progressEvent(507),

            onEventFinish =
            {
                [507] = function(player, csid, option, npc)
                    -- This quest specifically has wiki notes that it shows back up in the quest log for repeats
                    -- To achieve this, we delete it from the players log then accept it
                    player:delQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.SECRETS_OF_OVENS_LOST)
                    quest:begin(player)
                end,
            },
        },
    },
}

return quest
