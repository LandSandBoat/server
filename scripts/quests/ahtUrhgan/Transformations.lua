-----------------------------------
-- Transformations
-----------------------------------
-- Log ID: 6, Quest ID: 23
-- Waoud              : !pos 65 -6 -78 50
-- Imperial Whitegate : !pos 152 -2 0 50
-- Alzadaal (Blank)   : !pos -529.704 0 649.682 72
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require("scripts/globals/status")
require('scripts/globals/settings')
-----------------------------------
local alzadaalID  = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
local whitegateID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS)

quest.reward =
{
    item  = xi.items.MAGUS_KEFFIYEH,
    title = xi.title.PARAGON_OF_BLUE_MAGE_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS) and
                player:getMainJob() == xi.job.BLU and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    local lastDivination = xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer')

                    if
                        lastDivination <= VanadielUniqueDay() and
                        not quest:getMustZone(player)
                    then
                        if quest:getVar(player, 'Prog') == 0 then
                            return quest:progressEvent(720, player:getGil())
                        else
                            return quest:progressEvent(721, player:getGil())
                        end
                    end
                end,
            },

            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(722)
                    end
                end,
            },

            onEventFinish =
            {
                [720] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)

                        quest:setVar(player, 'Prog', 1)
                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,

                [721] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)

                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,

                [722] = function(player, csid, option, npc)
                    quest:begin(player)
                    player:setCharVar("[BLUAF]Remaining", 7) -- Player can now craft BLU armor
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    local lastDivination = xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL, 'Timer')

                    if lastDivination <= VanadielUniqueDay() then
                        return quest:progressEvent(723, player:getGil())
                    end
                end,
            },

            onEventFinish =
            {
                [723] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)

                        xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            ['blank_transformations'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 3 and
                        not GetMobByID(alzadaalID.mob.NEPIONIC_SOULFLAYER):isSpawned()
                    then
                        return quest:progressEvent(4)
                    elseif questProgress == 4 then
                        return quest:progressEvent(5)
                    end
                end,
            },

            ['Nepionic_Soulflayer'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [24] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(2)
                    end
                end,

                [25] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [4] = function(player, csid, option, npc)
                    npcUtil.popFromQM(player, npc, alzadaalID.mob.NEPIONIC_SOULFLAYER, { hide = 0 })
                end,

                [5] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
