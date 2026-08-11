-----------------------------------
-- Transformations (BLU AF3)
-----------------------------------
-- Log ID: 6, Quest ID: 23
-- Waoud              : !pos 65 -6 -78 50
-- Imperial Whitegate : !pos 152 -2 0 50
-- Alzadaal (Blank)   : !pos -529.704 0 649.682 72
-----------------------------------
-- The Beast Within opens one minute after this quest completes.
-- The June 7, 2016 version update shortened the wait from one Earth day.
--
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-----------------------------------
local alzadaalID  = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS)

quest.reward =
{
    item  = xi.item.MAGUS_KEFFIYEH,
    title = xi.title.PARAGON_OF_BLUE_MAGE_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS) and
                player:getMainJob() == xi.job.BLU and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getMustZone(player) or
                        GetSystemTime() < quest:getVar(player, 'Timer')
                    then
                        return
                    end

                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(720, player:getGil())
                    else
                        return quest:progressEvent(721, player:getGil())
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
                    end
                end,

                [721] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)
                    end
                end,

                [722] = function(player, csid, option, npc)
                    quest:begin(player)
                    player:setCharVar('[BLUAF]Remaining', 7) -- Player can now craft BLU armor
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(723, player:getGil())
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
                    if quest:complete(player) then
                        xi.quest.setVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN, 'Timer', GetSystemTime() + 60) -- 1 minute wait time
                    end
                end,
            },
        },
    },
}

return quest
