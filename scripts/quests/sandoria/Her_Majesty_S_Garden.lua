-----------------------------------
-- Her Majestys Garden
-----------------------------------
-- Log ID: 0, Quest ID: 62
-- Chalvatot : !gotoid 17731598
-- Map of the Northlands
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")

-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HER_MAJESTY_S_GARDEN)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    keyItem  = xi.ki.MAP_OF_THE_NORTHLANDS_AREA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 4
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 and player:getNation() ~= xi.nation.SANDORIA then -- Non sandy folk gets a CS prior to getting acceptance
                        return quest:progressEvent(583)
                    elseif questProgress == 0 and player:getNation() == xi.nation.SANDORIA then -- Sandy folks go directly to CS acceptance
                        return quest:progressEvent(84)
                    elseif questProgress == 1 then
                        return quest:progressEvent(84)
                    end
                end,
            },

            onEventFinish =
            {
                [583] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [84] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(82)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.CHUNK_OF_DERFLAND_HUMUS }) then
                        return quest:progressEvent(83)
                    end
                end,

            },

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
