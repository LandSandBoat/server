-----------------------------------
-- The Fanged One
-----------------------------------
-- Log ID: 2, Quest ID: 31
-- Perih Vashai: !pos 117 -3 92 241
-- Tiger Bones: !pos 666 -8 -379 120
-- Keeping Old Sabertooth and Tiger Bones in separate lua's due to special functions.
-----------------------------------
local windurstWoodsID = zones[xi.zone.WINDURST_WOODS]
local sauromugueID    = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.WINDURST,
    item     = xi.item.RANGERS_NECKLACE,
    title    = xi.title.THE_FANGED_ONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(351),

            onEventFinish =
            {
                [351] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(352)
                    elseif player:hasKeyItem(xi.ki.OLD_TIGERS_FANG) then
                        return quest:progressEvent(357)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.BLACK_TIGER_FANG) then
                        return quest:event(356)
                    end
                end,
            },

            ['Kapeh_Myohrye'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(354)
                end,
            },

            ['Muhk_Johldy'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(353)
                end,
            },

            onEventFinish =
            {
                [356] = function(player, csid, option, npc)
                    player:tradeComplete() -- capture shows taking black tiger fang if traded.
                end,

                [357] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_TIGERS_FANG)
                        player:unlockJob(xi.job.RNG)
                        npcUtil.giveKeyItem(player, xi.ki.JOB_GESTURE_RANGER)
                        player:messageSpecial(windurstWoodsID.text.PERIH_VASHAI_DIALOG)
                        quest:setMustZone(player)
                    end
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        -- The logic for this specific mechanic is unique. Therefore, the mob logic and onMobDeath
        -- resides in the Old_Sabertooth.lua onMobSpawn, onMobFight, and onMobDeath.
        -- Currently, unable to have the onMobDeath function load from this file due to enmity.
        -- Issue was raised to LSB for consideration on how to adjust moving forward.
        {
            ['Tiger_Bones'] =
            {
                onTrigger = function(player, npc)
                    local oldTiger = GetMobByID(sauromugueID.mob.OLD_SABERTOOTH)

                    if not oldTiger then
                        return quest:noAction()
                    end

                    if
                        quest:getVar(player, 'Timer') > GetSystemTime() and
                        not player:hasKeyItem(xi.ki.OLD_TIGERS_FANG)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.OLD_TIGERS_FANG)
                        quest:setVar(player, 'Prog', 1)
                        return quest:noAction()
                    elseif
                        quest:getVar(player, 'Prog') == 0 and
                        quest:getVar(player, 'Wait') <= GetSystemTime() and
                        not oldTiger:isSpawned()
                    then
                        SpawnMob(sauromugueID.mob.OLD_SABERTOOTH)
                        return quest:messageSpecial(sauromugueID.text.OLD_SABERTOOTH_DIALOG_I)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(358)
                    end
                end,
            },
        },
    },
}

return quest
