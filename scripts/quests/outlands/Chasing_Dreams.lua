-----------------------------------
-- Chasing Dreams
-----------------------------------
-- Log ID: 5, Quest ID: 195
--  Datta: !pos -6 -25 5
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.CHASING_DREAMS)

quest.reward =
{
    fame     = 30,
    item     = xi.items.VENERER_RING,
    fameArea = xi.quest.fame_area.SELBINA_RABAO,
    gil      = 4000,
}

local handleFlask = function(player)
    player:messageSpecial(ID.text.FILL_FLASK, xi.ki.WASHUS_FLASK)

    if quest:isVarBitsSet(player, 'Option', 1, 2, 3, 4) then
        player:delKeyItem(xi.ki.WASHUS_FLASK)
        player:messageSpecial(ID.text.FLASK_FULL, xi.ki.WASHUS_FLASK)
        npcUtil.giveKeyItem(player, xi.ki.FLASK_OF_CLAM_WATER)
        quest:setVar(player, 'Prog', 4)

    else
        player:messageSpecial(ID.text.STILL_LIGHT)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.RABAO] =
        {
            ['Rudolfo'] = quest:progressEvent(117),

            onEventFinish =
            {
                [117] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        -- Quest stage preceding and including getting clam water
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog <= 3
        end,

        [xi.zone.RABAO] =
        {
            ['Zoriboh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(119)
                    else
                        return quest:event(120)
                    end
                end,
            },

            onEventFinish =
            {
                [119] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Sohyon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(209)
                    else
                        -- Additional Dialogue
                        return quest:event(213)
                    end
                end,
            },

            ['Washu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(221)
                    end
                end,
            },

            onEventFinish =
            {
                [209] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
                [221] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.WASHUS_FLASK)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.KORROLOKA_TUNNEL] =
        {
            ['_4t0'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:isVarBitsSet(player, 'Option', 1) and
                        player:hasKeyItem(xi.ki.WASHUS_FLASK)
                    then
                        quest:setVarBit(player, 'Option', 1)
                        handleFlask(player)
                        return quest:noAction()
                    else
                        return quest:messageSpecial(ID.text.CLAM_EMPTY, xi.ki.WASHUS_FLASK)
                    end
                end,
            },
            ['_4t1'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:isVarBitsSet(player, 'Option', 2) and
                        player:hasKeyItem(xi.ki.WASHUS_FLASK)
                    then
                        quest:setVarBit(player, 'Option', 2)
                        handleFlask(player)
                        return quest:noAction()
                    else
                        return quest:messageSpecial(ID.text.CLAM_EMPTY, xi.ki.WASHUS_FLASK)
                    end
                end,
            },
            ['_4t2'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:isVarBitsSet(player, 'Option', 3) and
                        player:hasKeyItem(xi.ki.WASHUS_FLASK)
                    then
                        quest:setVarBit(player, 'Option', 3)
                        handleFlask(player)
                        return quest:noAction()
                    else
                        return quest:messageSpecial(ID.text.CLAM_EMPTY, xi.ki.WASHUS_FLASK)
                    end
                end,
            },
            ['_4t3'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:isVarBitsSet(player, 'Option', 4) and
                        player:hasKeyItem(xi.ki.WASHUS_FLASK)
                    then
                        quest:setVarBit(player, 'Option', 4)
                        handleFlask(player)
                        return quest:noAction()
                    else
                        return quest:messageSpecial(ID.text.CLAM_EMPTY, xi.ki.WASHUS_FLASK)
                    end
                end,
            },
        },
    },

    {
        -- Quest section suceeding having gathered the clam water
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog >= 4
        end,

        [xi.zone.NORG] =
        {
            ['Sohyon'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.FLASK_OF_CLAM_WATER) and
                        not player:hasKeyItem(xi.ki.STOREROOM_KEY)
                    then
                        return quest:progressEvent(210)
                    end
                end,
            },

            ['Gimb'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.STOREROOM_KEY) then
                        return quest:progressEvent(211, 0, xi.items.PINCH_OF_PRISM_POWDER)
                    end
                end,
            },

            onEventFinish =
            {
                [210] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.FLASK_OF_CLAM_WATER)
                    npcUtil.giveKeyItem(player, xi.ki.STOREROOM_KEY)
                end,
                [211] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.STOREROOM_KEY)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(322, 0, xi.items.EASTERN_GEM)
                    else
                        -- Additional Dialogue
                        return quest:event(324)
                    end
                end,
            },

            ['Patient_Wheel'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.items.EASTERN_GEM, 5 } }) and
                        quest:getVar(player, 'Prog') == 6
                    then
                        return quest:progressEvent(323)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 6 then
                        -- Additional Dialogue
                        return quest:event(326, 0, xi.items.EASTERN_GEM)
                    elseif quest:getVar(player, 'Prog') > 6 then
                        -- Additional Dialogue
                        return quest:event(327)
                    end
                end,
            },

            onEventFinish =
            {
                [322] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
                [323] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 7)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 7 then
                        return quest:progressEvent(1108)
                    end
                end,
            },

            onEventFinish =
            {
                [1108] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 8)
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 8 then
                        return 4
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 9)
                end,
            },
        },

        [xi.zone.RABAO] =
        {
            ['Zoriboh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 9 then
                        return quest:progressEvent(121)
                    end
                end,
            },

            onEventFinish =
            {
                [121] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
