-----------------------------------
-- The Crimson Trial
-- Variable Prefix: [0][84]
-----------------------------------
-- ZONE                NPC          POS
-- Southern San'doria, Sharzalion,  !pos 95   0 111 230
-- Southern San'doria, Valderotaux, !pos 97 0.1 113 230
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/keyitems")
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require("scripts/globals/status")
require('scripts/globals/interaction/quest')
-----------------------------------
local davoiID = require("scripts/zones/Davoi/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_CRIMSON_TRIAL)

quest.reward =
{
    item     = xi.items.FENCING_DEGEN,
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.RDM and
                player:getMainLvl() >= 40
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(70) -- First starting event.
                    else
                        return quest:progressEvent(71) -- Next starting event if originaly declined.
                    end
                end,
            },

            ['Valderotaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(54, player:getPlaytime())
                    end
                end,
            },

            onEventUpdate =
            {
                [54] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(54, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Prog', 1) -- This variable only means you rejected the quest when first offered.
                    end
                end,

                [71] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.DAVOI] =
        {
            ['Storage_Hole'] =
            {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(davoiID.text.AN_ORCISH_STORAGE_HOLE)
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.DAVOI_STORAGE_KEY) and
                        not player:hasKeyItem(xi.ki.ORCISH_DRIED_FOOD)
                    then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.ORCISH_DRIED_FOOD)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        not player:hasKeyItem(xi.ki.ORCISH_DRIED_FOOD) and
                        not GetMobByID(davoiID.mob.PURPLEFLASH_BRUKDOK):isSpawned()
                    then
                        SpawnMob(davoiID.mob.PURPLEFLASH_BRUKDOK) -- Spawned by Quest: The Crimson Trial upon entering the zone
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ORCISH_DRIED_FOOD) then
                        return quest:progressEvent(75) -- Finish quest.
                    else
                        return quest:event(74) -- Reminder.
                    end
                end,
            },

            ['Valderotaux'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(54, player:getPlaytime())
                end,
            },

            onEventUpdate =
            {
                [54] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(54, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ORCISH_DRIED_FOOD)
                    end
                end,
            },
        },
    },
}

return quest
