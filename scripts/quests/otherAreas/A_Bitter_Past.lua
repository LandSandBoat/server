-----------------------------------
-- A Bitter Past
-----------------------------------
-- Log ID: 4, Quest ID: 66
-- Frescheque : !pos 18 -36 12
-- Raminey    : !pos 82 -35 50
-- Equette    : !pos 3 -22 -17
-- ???        : !pos 58 -7 27
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_BITTER_PAST)

quest.reward =
{
    item = xi.items.YINYANG_LORGNETTE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Fresheque'] = quest:progressEvent(151),

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
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
            ['Fresheque'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TINY_WRISTLET) then
                    else
                        return quest:event(158)
                    end
                end,
            },
            ['Raminey'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                    return quest:event(152)
                    end
                end,
            },
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(153)
                    end
                end,
            },

            onEventFinish =
            {
                [152] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [153] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [158] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TINY_WRISTLET)
                    end
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            ['qm_bitter_past'] =
            {
                onTrigger = function(player, npc)
                    local mobIDs =
                    {
                        16875775,
                        16875776,
                    }
                    if quest:getVar(player, 'Prog') == 2 then
                        npcUtil.popFromQM(player, npc, mobIDs, {claim = true})
                    elseif not player:hasKeyItem(xi.ki.TINY_WRISTLET) then
                        npcUtil.giveKeyItem(player, xi.ki.TINY_WRISTLET)
                    end
                end,
            },

            ['Splinterspine_Grukjuk'] =
            {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    local party = player:getParty()

                    for _, v in ipairs(party) do
                        if v:getZone() == player:getZone() and quest:getVar(v, 'Prog') == 2 then
                            quest:setVar(v, 'Prog', 3)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                quest:getVar(player, 'Prog') == 3
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(155)
                end,
            },

            onEventFinish =
            {
                [155] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
}
