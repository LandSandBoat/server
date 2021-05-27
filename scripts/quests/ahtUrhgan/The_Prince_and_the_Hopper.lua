-----------------------------------
-- The Prince and the Hopper
-----------------------------------
-- Log ID: 6, Quest ID: 67
-- Maudaal          : !pos -147.198 1.8 -3.121 50
-- Toads Footprint2 : !pos 216.1 -23.818 -102.464 65
-- Toads Footprint1 : !pos -42.9248 5.9847 -100.2972 65
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/zone")
require('scripts/globals/interaction/quest')
-----------------------------------
local mamookID = require("scripts/zones/Mamook/IDs")
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
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 1 then
                        -- This event should only fire when zoning into Wajaoam Woodlands
                        -- through the secret exit, as the player was instructed.
                        if prevZone == xi.zone.AHT_URHGAN_WHITEGATE then
                            return 513
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [513] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.MAMOOK] =
        {
            ['Toads_Footprint2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(222)
                    end
                end,
            },

            ['Toads_Footprint1'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 3 then
                        return quest:progressEvent(223)
                    elseif questProgress == 4 then
                        if npcUtil.popFromQM(player, npc, spawnedMobs, {hide = 1}) then
                            player:messageSpecial(mamookID.text.DRAWS_NEAR)
                        end
                    elseif questProgress == 5 then
                        return quest:progressEvent(225)
                    end
                end,
            },

            ['Poroggo_Casanova'] =
            {
                onMobDeath = function(mob, player, isKiller, noKiller)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                    end

                    for i = mamookID.mob.POROGGO_CASANOVA + 1, mamookID.mob.POROGGO_CASANOVA + 5 do
                        DespawnMob(i)
                    end
                end,
            },

            onEventFinish =
            {
                [222] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    return quest:event(227)
                end,

                [223] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [225] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,
            },
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Maudaal'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 6 then
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
