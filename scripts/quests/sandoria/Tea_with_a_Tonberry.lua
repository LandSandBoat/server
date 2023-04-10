-----------------------------------
-- Tea with a Tonberry?
-- Sobane !pos -190 -3 97 230
-- Anguenet !pos 214.672 -3.013 -527.561 2
-- PIECE_OF_ATTOHWA_GINSENG !additem 1683
-- Riche !pos 5.945 -3.75 13.612 1
-- INGOT_OF_ROYAL_TREASURY_GOLD !additem 1682
-- Davoi qm2 !pos 189.201 1.2553 -383.921 149
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/items')
-----------------------------------
local phanauetID = require('scripts/zones/Phanauet_Channel/IDs')
local davoiID = require('scripts/zones/Davoi/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TEA_WITH_A_TONBERRY)

quest.reward =
{
    item = xi.items.WILLPOWER_TORQUE,
    title = xi.title.TALKS_WITH_TONBERRIES,
}

quest.sections =
{
    -- Talk to Sobane. She and her husband need your help confirming a threat to a local aristocrat, but the only ones
    -- who may know about it are the tight lipped Tonberries in Carpenters' Landing.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SIGNED_IN_BLOOD) == QUEST_COMPLETED and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 4 and
                not player:needToZone()
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(738)
                end,
            },

            onEventFinish =
            {
                [738] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Travel to Attohwa Chasm and defeat Gallinipper, Ogrefly, or Monarch Ogrefly until they drop Attohwa Ginseng.
    -- Travel to South Landing in Carpenters' Landing. Talk with Anguenet at the docks for a cutscene.
    -- Trade Anguenet the Attohwa Ginseng and he will give you the Tonberry Blackboard.
    -- Board a barge headed for Central Landing via Emfea Way.
    -- Talk to Riche, the Tonberry on board. Ask him all the questions (5); at the end he'll take the key item.
    -- Be sure to do this before the ride is over, which is approximately 7 minutes.
    -- Travel to Fei'Yin and kill Shadow until they drop Treasury Gold.
    -- Take the Treasury Gold to Davoi and trade it to the ??? at (J-11), which spawns a Hematic Cyst NM.
    -- Kill the Hematic Cyst and select the ??? again for a cutscene.
    -- Return to Southern San d'Oria and talk to Sobane to complete the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(740)
                    else
                        return quest:event(739)
                    end
                end,
            },

            onEventFinish =
            {
                [740] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['Anguenet'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(27, 0, xi.items.PIECE_OF_ATTOHWA_GINSENG)
                    elseif progress == 1 then
                        return quest:replaceEvent(28, 0, xi.items.PIECE_OF_ATTOHWA_GINSENG)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHas(trade, xi.items.PIECE_OF_ATTOHWA_GINSENG)
                    then
                        return quest:progressEvent(29)
                    end
                end
            },

            onEventFinish =
            {
                [27] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [29] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.keyItem.TONBERRY_BLACKBOARD)
                    quest:setVar(player, 'Prog', 2)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.PHANAUET_CHANNEL] =
        {
            ['Riche'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.TONBERRY_BLACKBOARD) then
                        return quest:progressEvent(5, 1, 627, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD, 63, 3, 30, 30, 0)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:messageName(phanauetID.text.RICHE_DAVOI_WATERFALL, 0, 0, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD):replaceDefault()
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    player:delKeyItem(xi.keyItem.TONBERRY_BLACKBOARD) -- No message as the cutscene ends with the NPC taking it
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 3 then
                        return quest:messageSpecial(davoiID.text.WHERE_THE_TONBERRY_TOLD_YOU, 0, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD)
                    elseif progress == 4 then
                        return quest:event(126, 149, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD)
                    elseif progress == 5 then
                        return quest:messageSpecial(davoiID.text.NOTHING_TO_DO)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        npcUtil.tradeHas(trade, xi.items.INGOT_OF_ROYAL_TREASURY_GOLD) and
                        npcUtil.popFromQM(player, npc, davoiID.mob.HEMATIC_CYST, { radius = 1, hide = 0 })
                    then
                        player:confirmTrade()
                        return quest:messageSpecial(davoiID.text.UNDER_ATTACK)
                    end
                end,
            },

            ['Hematic_Cyst'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },

            onEventFinish =
            {
                [126] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },
}

return quest
