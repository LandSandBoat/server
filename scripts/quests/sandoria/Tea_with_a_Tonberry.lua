-----------------------------------
-- Tea with a Tonberry?
-- Sobane !pos -190 -3 97 230
-- Anguenet !pos 214.672 -3.013 -527.561 2
-- Riche !pos 5.945 -3.75 13.612 1
-- Davoi qm2 !pos 189.201 1.2553 -383.921 149
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------
local CarpentersLandingID = require("scripts/zones/Carpenters_Landing/IDs")
local DavoiID = require("scripts/zones/Davoi/IDs")


local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TEA_WITH_A_TONBERRY)

quest.repeatable = false
quest.reward = {
    item = xi.items.WILLPOWER_TORQUE,
}

quest.sections = {
    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
                and player:getQuestStatus(SANDORIA, SIGNED_IN_BLOOD) == QUEST_COMPLETED
                and player:getFameLevel(SANDORIA) >= 4
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Sobane'] = {
                onTrigger = function(player, npc)
                    if player:needToZone() then
                        return quest:event(737)
                    else
                        return quest:progressEvent(738)
                    end
                end,
            },

            onEventFinish = {
                [738] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] = {
            ['Anguenet'] = quest:event(21),
        },
    },

    -- Section: Questing
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Sobane'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, "Prog") == 5 then
                        return quest:progressEvent(740)
                    else
                        return quest:event(739)
                    end
                end,
            },

            onEventFinish = {
                [740] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] = {
            ['Anguenet'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, "Prog")

                    if progress == 0 then
                        return quest:progressEvent(27, { [1] = xi.items.PIECE_OF_ATTOHWA_GINSENG })
                    elseif progress == 1 then
                        return quest:replaceEvent(28, { [1] = xi.items.PIECE_OF_ATTOHWA_GINSENG })
                    end
                end,

                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 1
                        and npcUtil.tradeHas(trade, xi.items.PIECE_OF_ATTOHWA_GINSENG) then
                        return quest:progressEvent(29)
                    end
                end
            },

            onEventFinish = {
                [27] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [29] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:addKeyItem(xi.keyItem.TONBERRY_BLACKBOARD)
                    player:messageSpecial(CarpentersLandingID.text.KEYITEM_OBTAINED, xi.keyItem.TONBERRY_BLACKBOARD)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.PHANAUET_CHANNEL] = {
            ['Riche'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.TONBERRY_BLACKBOARD) then
                        return quest:progressEvent(5, 1, 627, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD, 63, 3, 30, 30, 0)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:replaceMessage(7406)
                    end
                end,
            },

            onEventFinish = {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    player:delKeyItem(xi.keyItem.TONBERRY_BLACKBOARD) -- No message as the cutscene ends with the NPC taking it
                end,
            },
        },

        [xi.zone.DAVOI] = {
            ['qm2'] = {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, "Prog")

                    if progress == 3 then
                        return quest:messageSpecial(DavoiID.text.TONBERRY_GOLD, 0, 1682)
                    elseif progress == 4 then
                        return quest:event(126, 149, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD)
                    elseif progress == 5 then
                        return quest:messageText(DavoiID.text.NOTHING_TO_DO, false)
                    else
                        return quest:messageSpecial(DavoiID.text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD)
                        and not GetMobByID(DavoiID.mob.HEMATIC_CYST):isSpawned() then
                        -- Treasury Gold spawns Hematic Cyst
                        SpawnMob(DavoiID.mob.HEMATIC_CYST):updateClaim(player)
                        player:confirmTrade()
                        return quest:message(DavoiID.text.UNDER_ATTACK, false)
                    end
                end,
            },

            ['Hematic_Cyst'] = {
                onMobDeath = function(mob, player, isKiller)
                    quest:setVar(player, 'Prog', 4)
                end,
            },

            onEventFinish = {
                [126] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },
}


return quest
