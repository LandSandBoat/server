-----------------------------------
-- Waking Dreams
-----------------------------------
-- NPCs:
--  Kerutoto (Windurst Waters) !pos 13 -5 -157
-- Tools:
--  !addquest 2 93
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)

quest.sections =
{
    {
        check = function(player, status, vars)
            return status ~= QUEST_ACCEPTED and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) and
                not player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE) and
                not player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) and
                vars.Stage < os.time()
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] = quest:progressEvent(918),

            onEventFinish =
            {
                [918] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_DREAM_INCENSE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) then
                        local availRewards = 0
                            + (player:hasItem(xi.items.DIABOLOSS_POLE) and 1 or 0)    -- Diabolos's Pole
                            + (player:hasItem(xi.items.DIABOLOSS_EARRING) and 2 or 0) -- Diabolos's Earring
                            + (player:hasItem(xi.items.DIABOLOSS_RING) and 4 or 0)    -- Diabolos's Ring
                            + (player:hasItem(xi.items.DIABOLOSS_TORQUE) and 8 or 0)  -- Diabolos's Torque
                            + (player:hasSpell(304) and 32 or 16) -- Pact or gil

                        return quest:progressEvent(920,
                            xi.items.DIABOLOSS_POLE,
                            xi.items.DIABOLOSS_EARRING,
                            xi.items.DIABOLOSS_RING,
                            xi.items.DIABOLOSS_TORQUE,
                            0, 0, 0, availRewards)
                    end
                end,
            },

            onEventUpdate =
            {
                [920] = function(player, csid, option, npc)
                    local availRewards = 0
                        + (player:hasItem(xi.items.DIABOLOSS_POLE) and 1 or 0)    -- Diabolos's Pole
                        + (player:hasItem(xi.items.DIABOLOSS_EARRING) and 2 or 0) -- Diabolos's Earring
                        + (player:hasItem(xi.items.DIABOLOSS_RING) and 4 or 0)    -- Diabolos's Ring
                        + (player:hasItem(xi.items.DIABOLOSS_TORQUE) and 8 or 0)  -- Diabolos's Torque
                        + (player:hasSpell(304) and 32 or 16) -- Pact or gil

                    player:updateEvent(xi.items.DIABOLOSS_POLE,
                        xi.items.DIABOLOSS_EARRING,
                        xi.items.DIABOLOSS_RING,
                        xi.items.DIABOLOSS_TORQUE,
                        0, 0, 0, availRewards)
                end
            },

            onEventFinish =
            {
                [920] = function(player, csid, option, npc)
                    quest.reward.item = nil
                    quest.reward.gil = nil

                    if option == 1 and not player:hasItem(xi.items.DIABOLOSS_POLE) then
                        quest.reward.item = xi.items.DIABOLOSS_POLE

                    elseif option == 2 and not player:hasItem(xi.items.DIABOLOSS_EARRING) then
                        quest.reward.item = xi.items.DIABOLOSS_EARRING

                    elseif option == 3 and not player:hasItem(xi.items.DIABOLOSS_RING) then
                        quest.reward.item = xi.items.DIABOLOSS_RING

                    elseif option == 4 and not player:hasItem(xi.items.DIABOLOSS_TORQUE) then
                        quest.reward.item = xi.items.DIABOLOSS_TORQUE

                    elseif option == 5 then
                        quest.reward.gil = 15000

                    elseif option == 6 and not player:hasSpell(304) then
                        player:addSpell(304)
                        player:messageSpecial(ID.text.DIABOLOS_UNLOCKED)
                    end

                    if quest:complete(player, quest) then
                        player:delKeyItem(xi.ki.WHISPER_OF_DREAMS)
                        quest:setVar(player, 'Stage', getMidnight())
                    end
                end,
            },
        },
    },
}

return quest
