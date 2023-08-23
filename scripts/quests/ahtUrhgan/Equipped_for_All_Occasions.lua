-----------------------------------
-- Equipped for All Occasions
-- Corsair AF1 Quest
-----------------------------------
-- Log ID: 6, Quest ID: 24
-- qm6 (H-10/Boat)  : !pos 468.767 -12.292 111.817 54
-- _5i0 (Iron Door) : !pos 247.735 18.499 -142.267 198
-- Ratihb           : !pos 75.225 -6.000 -137.203 50
-----------------------------------
local mazeID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)

quest.reward =
{
    item  = xi.item.TRUMP_GUN,
}

quest.sections =
{
    -- Section: Quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(228)
                end,
            },

            onEventFinish =
            {
                [228] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['_5i0'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        npcUtil.popFromQM(player, npc, mazeID.mob.LOST_SOUL, { hide = 0 })
                    elseif questProgress == 2 then
                        return quest:progressEvent(66)
                    end
                end,
            },

            ['Lost_Soul'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },

            onEventFinish =
            {
                [66] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.WHEEL_LOCK_TRIGGER)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(231)
                    end
                end,
            },

            onEventFinish =
            {
                [231] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.WHEEL_LOCK_TRIGGER)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] =
            {
                onTrigger = function(player, npc)
                    -- Variable 'Stage' is set on quest 'Luck of the Draw', on section 'Quest completed'.
                    if quest:getVar(player, 'Prog') == 4 and quest:getVar(player, 'Stage') == 1 then
                        return quest:progressEvent(772)
                    end
                end,
            },

            onEventFinish =
            {
                [772] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
