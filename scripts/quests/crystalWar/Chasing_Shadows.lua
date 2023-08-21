-----------------------------------
-- Chasing Shadows
-----------------------------------
-- !addquest 7 60
-- Rongelouts        : !pos 0.067 2 -22 80
-- Backfilled Pit    : !pos -172 -2.818 -85 137
-- Compact Footprint : !pos 242.145 -15.42 -147.417 137
-- Sunken Footprint  : !pos 188.429 -27.623 163.764 137
-- Fresh Snowmelt    : !pos -71.660 -2.58 450.114 84
-----------------------------------
local pastBatalliaID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CHASING_SHADOWS)

quest.reward =
{
    item = xi.item.DARKSTEEL_SHEET,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BLOOD_OF_HEROES) and
                quest:getVar(player, 'Timer') <= VanadielUniqueDay()
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont']              = quest:event(656),
            ['Rongelouts_N_Distaud'] = quest:progressEvent(165),

            onEventFinish =
            {
                [165] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont']              = quest:event(167),
            ['Rongelouts_N_Distaud'] = quest:event(168),
        },

        [xi.zone.XARCABARD_S] =
        {
            ['Backfilled_Pit'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(31)
                    end
                end,
            },

            ['Compact_Footprint'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(32)
                    elseif questProgress == 4 then
                        return quest:progressEvent(34)
                    end
                end,
            },

            ['Sunken_Footprint'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(33)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.BEAUCEDINE_GLACIER_S and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return 30
                    end
                end,
            },

            onEventFinish =
            {
                [30] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [31] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [32] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [33] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [34] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Fresh_Snowmelt'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 6 then
                        return quest:progressEvent(115)
                    elseif
                        questProgress == 7 and
                        not GetMobByID(pastBatalliaID.mob.MENECHME):isSpawned()
                    then
                        -- TODO: Menechme has been set to Level 150 until proper data is obtained, and
                        -- Excenmille assists in this fight who is currently set to level 0 and not spawned
                        -- at this time.  Menecheme by default will approach Excenmille and attack.

                        return quest:progressEvent(116)
                    elseif questProgress == 8 then
                        return quest:progressEvent(117)
                    end
                end,
            },

            ['Menechme'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 7 then
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.BEAUCEDINE_GLACIER_S and
                        quest:getVar(player, 'Prog') == 5
                    then
                        return 114
                    end
                end,
            },

            onEventFinish =
            {
                [114] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [115] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,

                [116] = function(player, csid, option, npc)
                    SpawnMob(pastBatalliaID.mob.MENECHME)
                end,

                [117] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.FACE_OF_THE_FUTURE)
                        player:setPos(-49.903, 0.293, 436.922, 0, xi.zone.BATALLIA_DOWNS)
                    end
                end,
            },
        },
    },
}

return quest
