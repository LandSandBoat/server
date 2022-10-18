-----------------------------------
-- The Prince and the Hopper
-----------------------------------
-- Log ID: 6, Quest ID: 67
-- Maudaal          : !pos -147.198 1.8 -3.121 50
-- Toads Footprint2 : !pos 216.1 -23.818 -102.464 65
-- Toads Footprint1 : !pos -42.9248 5.9847 -100.2972 65
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local mamookID = require('scripts/zones/Mamook/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER)

local spawnedMobs =
{
    mamookID.mob.MIKILULU,
    mamookID.mob.MIKIRURU,
    mamookID.mob.NIKILULU,
    mamookID.mob.MIKILURU,
    mamookID.mob.MIKIRULU,
    mamookID.mob.POROGGO_CASANOVA,
}

quest.reward =
{
    item = xi.items.CHANOIXS_GORGET
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Maudaal'] = quest:progressEvent(889),

            onEventFinish =
            {
                [889] = function(player, csid, option, npc)
                    if option == 2 then
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

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 0 then
                        local xPos = player:getXPos()
                        local yPos = player:getYPos()
                        local zPos = player:getZPos()

                        if
                            xPos >= 680.0 and yPos >= -19.0 and zPos >= 218.0 and
                            xPos <= 691.0 and yPos <= -14.0 and zPos <= 221.0
                        then
                            return 513
                        end
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return 20
                    end
                end,
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc) -- end of zone in cutscene
                    quest:setVar(player, 'Prog', 3)
                    -- zone the person back to mamook
                    player:setPos(216.100, -23.818, -102.464, 0, 65)
                end,

                [513] = function(player, csid, option, npc) -- end of zone in cutscene
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.MAMOOK] =
        {
            ['Toads_Footprint2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(222)
                    end
                end,
            },

            ['Toads_Footprint1'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 4 then
                        return quest:progressEvent(223)
                    elseif questProgress == 5 then
                        -- missing special spawn animation, cannot find in packet capture.
                        if npcUtil.popFromQM(player, npc, spawnedMobs, { hide = 1 }) then
                            player:messageSpecial(mamookID.text.IMPENDING_BATTLE)
                        end
                    elseif questProgress == 6 then
                        return quest:progressEvent(225)
                    end
                end,
            },

            ['Poroggo_Casanova'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 5 then
                        quest:setVar(player, 'Prog', 6)
                    end

                    for i = mamookID.mob.POROGGO_CASANOVA + 1, mamookID.mob.POROGGO_CASANOVA + 5 do
                        DespawnMob(i)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 3 then
                        return 227
                    end
                end,
            },

            onEventFinish =
            {
                [222] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    -- Zone the person to Wajaom for second part of cs
                    player:setPos(610.542, -28.547, 356.247, 0, xi.zone.WAJAOM_WOODLANDS)
                end,

                [223] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [225] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,

                [227] = function(player, csid, option, npc) -- end of 2nd zone in cutscene
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Maudaal'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 7 then
                        return quest:progressEvent(890)
                    end
                end,
            },

            onEventFinish =
            {
                [890] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
