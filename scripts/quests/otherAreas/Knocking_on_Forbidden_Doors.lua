-----------------------------------
-- Knocking on Forbidden Doors
-----------------------------------
-- Log ID: 4, Quest ID: 78
-- Enaremand       : !pos
-- Fyi_Chalmwoh    : !pos -39.273 -16.000 70.126 249
-- Mire Incense KI : 709
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/mannequins')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local mhauraID = require('scripts/zones/Mhaura/IDs')
local phomiunaID = require('scripts/zones/Phomiuna_Aqueducts/IDs')
local misareauxID = require('scripts/zones/Misareaux_Coast/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.KNOCKING_ON_FORBIDDEN_DOORS)

quest.sections =
{
    -- START: Talk to Enaremand (J-7) on the upper level in Tavnazian Safehold
    -- QUEST AVAILABLE
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.BEHIND_THE_SMILE)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Enaremand'] = quest:progressEvent(535),

            onEventFinish =
            {
                [535] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- QUEST ACCEPTED
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Chemioue'] =
            {
                onTrigger = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(536)
                    end
                end,
            },

            onEventFinish =
            {
                [536] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.PHOMIUNA_AQUEDUCTS] =
        {
            ['Wooden_Ladder'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npc:getID() == phomiunaID.npc.LADDER_KNOCKING
                    then -- Find a better way to identify exactly which ladder it is in case IDs shift
                        return quest:progressEvent(38, 27) -- Essentially chains the ladder cs with the actual quest cs
                    end
                end,
            },

            onEventFinish =
            {
                [38] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['qm_mire_incense'] =
            {
                onTrigger = function(player, npc)
                    --- ??? by end of river
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        not player:hasKeyItem(xi.ki.MIRE_INCENSE)
                    then
                        return quest:keyItem(xi.ki.MIRE_INCENSE)
                    end
                end,
            },

            ['qm_alsha'] =
            {
                onTrigger = function(player, npc)
                    local progressVar = quest:getVar(player, 'Prog')
                    -- First time clicking on ???
                    if
                        player:hasKeyItem(xi.ki.MIRE_INCENSE) and
                        progressVar == 2
                    then
                        return quest:progressEvent(556, { [1] = xi.ki.MIRE_INCENSE })

                    -- Second time clicking on ???
                    elseif progressVar == 3 then
                        return quest:progressEvent(557, { [1] = xi.ki.MIRE_INCENSE })

                    -- Clicking on the ??? after killing NM
                    elseif progressVar == 4 then
                        return quest:event(558)
                    end
                end,
            },

            ['Alsha'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },

            onEventFinish =
            {
                [556] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [557] = function(player, csid, option, npc)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        npcUtil.popFromQM(player, npc, ID.mob.ALSHA, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(misareauxID.text.FOUL_STENCH)
                    end
                end,

                [558] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    return quest:keyItem(xi.ki.BETTER_HUMES_AND_MANNEQUINS)
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Fyi_Chalmwoh'] =
            {
                onTrigger = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(321, { [0] = 704,
                            [1] = xi.mannequin.getMannequins(player),
                            [2] = xi.mannequin.cost.PURCHASE,
                            [3] = xi.mannequin.cost.TRADE,
                            [4] = xi.mannequin.cost.POSE,
                            [5] = player:getGil(),
                            [6] = xi.ki.BETTER_HUMES_AND_MANNEQUINS })
                    end
                end,
            },

            onEventFinish =
            {
                [321] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },

        }
    },

    -- Quest complete
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                player:hasKeyItem(xi.ki.BETTER_HUMES_AND_MANNEQUINS)
        end,

        [xi.zone.MHAURA] =
        {
            ['Fyi_Chalmwoh'] =
            {
                onTrigger = function(player, csid, option, npc)
                    return quest:event(321, { [1] = xi.mannequin.getMannequins(player),
                        [2] = xi.mannequin.cost.PURCHASE,
                        [3] = xi.mannequin.cost.TRADE,
                        [4] = xi.mannequin.cost.POSE,
                        [5] = player:getGil(),
                        })
                end,

                onTrade = function(player, npc, trade)
                    -- Trade exactly one mannequin without gil.  Gil taken separately.
                    local tradedMannequin = 0

                    for itemId = xi.items.HUME_M_MANNEQUIN, xi.items.GALKA_MANNEQUIN do
                        if npcUtil.tradeHasExactly(trade, itemId) then
                            tradedMannequin = itemId
                        end
                    end

                    if tradedMannequin then
                        return quest:progressEvent(319, { [0] = 2,
                            [1] = xi.mannequin.getMannequins(player), -- Player Mannequin List
                            [2] = xi.mannequin.cost.PURCHASE,
                            [3] = xi.mannequin.cost.TRADE,
                            [4] = 1, -- Leaving this out gives a "It's still in pretty good condition" message
                            })
                    end
                end,
            },

            onEventUpdate =
            {
                [321] = function(player, csid, option, npc)
                    if option == 0 then
                        -- Purchase a mannequin
                        local richEnough = 0
                        if player:getGil() >= xi.mannequin.cost.PURCHASE then
                            richEnough = 1
                        end

                        player:updateEvent({ [0] = richEnough, -- Not sure if this is the legitimate use, but it works.
                            [1] = xi.mannequin.getMannequins(player),
                            [2] = option,
                        })
                    elseif
                        option >= 11 and
                        option <= 18
                    then
                        -- Pose a mannequin
                        local race = option - 10 -- From 1 to 8, for consistency in lua
                        player:updateEvent({ [0] = 1,
                            [1] = xi.mannequin.getMannequins(player),
                            [2] = option,
                            [3] = xi.mannequin.getMannequinPose(player, race),
                        })
                    end
                end,
            },

            onEventFinish =
            {
                [319] = function(player, csid, option, npc)
                    -- Trade mannequin.  Option = race (1-8)
                    if
                        option >= 1 and
                        option <= 8 and
                        player:delGil(xi.mannequin.cost.TRADE)
                    then
                        player:confirmTrade()
                        npcUtil.giveItem(player, xi.items.HUME_M_MANNEQUIN + option - 1)
                    end
                end,

                [321] = function(player, csid, option, npc)
                    -- If the transaction failed, the option is nil.
                    if
                        -- Purchase the mannequin.  Option = race (1-8)
                        option >= 1 and
                        option <= 8 and
                        player:delGil(xi.mannequin.cost.PURCHASE)
                    then
                        player:messageSpecial(mhauraID.text.ITEM_OBTAINED, xi.items.HUME_M_MANNEQUIN + option - 1)
                        player:addItem(xi.items.HUME_M_MANNEQUIN + option - 1)
                    elseif
                        option >= 10 and
                        player:delGil(xi.mannequin.cost.POSE)
                    then
                        -- Posing a mannequin
                        local race = ((option - 11) % 8) + 1 -- 1 to 8 for lua consistency
                        local pose = math.floor(option / 32)
                        xi.mannequin.setMannequinPose(player, race, pose)
                    end
                end,
            },
        },
    },
}

return quest
