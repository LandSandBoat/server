-----------------------------------
-- Shadows of the Departed
-----------------------------------
-- Log ID: 3, Quest ID: 88
-- _0id : !pos 220 -2.5 340 18
-- _0gc : !pos 100.005 -3.028 -140.005 16
-- _0k0 : !pos 260 -2.5 180 20
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) and
                player:getCurrentMission(xi.mission.log_id.ZILART) == xi.mission.id.zilart.AWAKENING and
                player:getMissionStatus(xi.mission.log_id.ZILART) == 3 and
                VanadielUniqueDay() >= vars.Timer
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return quest:progressEvent(161)
                end,
            },

            onEventFinish =
            {
                [161] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.NOTE_WRITTEN_BY_ESHANTARL)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PROMYVION_DEM] =
        {
            ['_0id'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PROMYVION_DEM_SLIVER) then
                        return quest:keyItem(xi.ki.PROMYVION_DEM_SLIVER)
                    end
                end,
            },
        },

        [xi.zone.PROMYVION_HOLLA] =
        {
            ['_0gc'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER) then
                        return quest:keyItem(xi.ki.PROMYVION_HOLLA_SLIVER)
                    end
                end,
            },
        },

        [xi.zone.PROMYVION_MEA] =
        {
            ['_0k0'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PROMYVION_MEA_SLIVER) then
                        return quest:keyItem(xi.ki.PROMYVION_MEA_SLIVER)
                    end
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    for keyItemId = xi.ki.PROMYVION_HOLLA_SLIVER, xi.ki.PROMYVION_HOLLA_SLIVER + 2 do
                        if not player:hasKeyItem(keyItemId) then
                            return
                        end
                    end

                    return quest:progressEvent(162)
                end,
            },

            onEventFinish =
            {
                [162] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        for keyItemId = xi.ki.PROMYVION_HOLLA_SLIVER, xi.ki.PROMYVION_HOLLA_SLIVER + 2 do
                            player:delKeyItem(keyItemId)
                        end

                        player:messageSpecial(ruludeID.text.YOU_HAND_THE_THREE_SLIVERS)

                        xi.quest.setVar(player, xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
                    end
                end,
            },
        },
    },
}

return quest
