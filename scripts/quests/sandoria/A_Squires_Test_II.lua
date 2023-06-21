-----------------------------------
-- A Squire's Test II
-----------------------------------
-- Log ID: 0, Quest ID: 19
-- Balasiel : !pos -136 -11 64 230
-- qm2      : !pos -94 1 273 193
-- qm3      : !pos -139 0.1 264 193
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ordellesCavesID = require('scripts/zones/Ordelles_Caves/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST_II)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    keyItem  = xi.ki.SQUIRE_CERTIFICATE,
    title    = xi.title.SPELUNKER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 10 then
                        return quest:progressEvent(625)
                    else
                        return quest:event(671)
                    end
                end,
            },

            onEventFinish =
            {
                [625] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.STALACTITE_DEW) then
                        return quest:progressEvent(626)
                    else
                        return quest:event(630)
                    end
                end,
            },

            ['Chanpau'] = quest:event(629),

            onEventFinish =
            {
                [626] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.STALACTITE_DEW)
                    end
                end,

                [629] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Morjean'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:event(602)
                    end
                end,
            },
        },

        [xi.zone.ORDELLES_CAVES] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.STALACTITE_DEW) then
                        quest:setVar(player, 'Timer', os.time() + 30)
                    end

                    return quest:messageSpecial(ordellesCavesID.text.PLACE_HANDS_IN_POOL)
                end,
            },

            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.STALACTITE_DEW) then
                        if os.time() <= quest:getVar(player, 'Timer') then
                            return quest:keyItem(xi.ki.STALACTITE_DEW)
                        else
                            return quest:messageSpecial(ordellesCavesID.text.DEW_SLIPS_THROUGH_FINGERS)
                        end
                    else
                        return quest:messageSpecial(ordellesCavesID.text.ALREADY_OBTAINED_DEW)
                    end
                end,
            },
        },
    },
}

return quest
