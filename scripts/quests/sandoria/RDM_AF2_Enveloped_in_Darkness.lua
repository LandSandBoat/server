-----------------------------------
-- Enveloped in Darkness
-- Variable Prefix: [0][85]
-----------------------------------
-- ZONE                 NPC          POS
-- Chateau d'Oraguille, Curilla,     !pos 27 0.1 0.1 233
-- Northern San'doria,  Pagisalis,   !pos 97 0.1 113 231
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local crawlersID = require("scripts/zones/Crawlers_Nest/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS)

quest.reward =
{
    item     = xi.items.WARLOCKS_BOOTS,
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_CRIMSON_TRIAL) == QUEST_COMPLETED and
                player:getMainJob() == xi.job.RDM and
                player:getMainLvl() >= 50
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(94) -- First starting event.
                    else
                        return quest:progressEvent(95) -- Next starting event if originaly declined.
                    end
                end,
            },

            onEventFinish =
            {
                [94] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.OLD_POCKET_WATCH)
                    else
                        quest:setVar(player, 'Prog', 1) -- You rejected the quest when first offered.
                    end
                end,

                [95] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.OLD_POCKET_WATCH)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] = quest:event(68)
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 1 then
                        return quest:event(92) -- Church reminder.
                        -- NOTE: Curilla has a second posible reminder event in this step (event 93). From context, it seems time triggered.
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(101) -- Post church ghost event. (Optional)
                    else
                        return quest:event(107) -- Crawler blood reminder.
                    end
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3) -- Set optional event as seen.
                end,
            },
        },

        [xi.zone.CRAWLERS_NEST] =
        {
            ['qm8'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 2 then
                        if quest:getVar(player, 'Time') > 0 then
                            if quest:getVar(player, 'Time') <= os.time() then
                                return quest:progressEvent(5) -- Quest complete.
                            else
                                return quest:messageSpecial(crawlersID.text.EQUIPMENT_NOT_PURIFIED) -- Purification incomplete.
                            end
                        else
                            if
                                player:hasKeyItem(xi.ki.CRAWLER_BLOOD) and
                                player:hasKeyItem(xi.ki.OLD_BOOTS)
                            then
                                return quest:progressEvent(4) -- Loose key items. Start boot purification.
                            else
                                return quest:messageSpecial(crawlersID.text.SOMEONE_HAS_BEEN_DIGGING_HERE)
                            end
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Set purification time.
                        quest:setVar(player, 'Time', os.time() + 30)

                        -- Delete Key items.
                        player:delKeyItem(xi.ki.CRAWLER_BLOOD)
                        player:delKeyItem(xi.ki.OLD_BOOTS)

                        -- Message when acepting to bury boots and blood.
                        player:messageSpecial(crawlersID.text.YOU_BURY_THE, xi.ki.OLD_BOOTS, xi.ki.CRAWLER_BLOOD)
                    end
                end,

                [5] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Pagisalis'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SQUARE_OF_VELVET_CLOTH) then
                        return quest:progressEvent(37)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 2 then
                        return quest:event(58) -- After seing ghost.
                    else
                        return quest:event(48)
                    end
                end,
            },

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2) -- Saw ghost.
                    player:tradeComplete()
                    player:delKeyItem(xi.ki.OLD_POCKET_WATCH)
                    npcUtil.giveKeyItem(player, xi.ki.OLD_BOOTS)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 2 then
                        return quest:event(69) -- After seing ghost.
                    else
                        return quest:event(68)
                    end
                end,
            },
        },
    },
}

return quest
