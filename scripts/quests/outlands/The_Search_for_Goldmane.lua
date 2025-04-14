-----------------------------------
-- The Search for Goldmane
-----------------------------------
-- Log ID: 5, Quest ID: 200
-- Rabao: !zone 247
-- Zoriboh: !pos -43 8 82
-- Tavnazian Safehold: !zone 26
-- Quelveuiat: !pos 1.066 -22.750 -25.077
-- Riverne Site A01: !zone 30
-- Spatial_Displacement: !pos 260.72 75.50 -905.92
-- Trunk: !pos 163.96 96.40 -875.02
-- Metalworks: !zone 237
-- Vladinek: !pos -17.19 -10.00 -20.76
-- Bibiki Bay: !zone 4
-- Weathered_Boat: !pos -620.43 -0.58 -698.72
-- Rabao: !zone 247
-- Zoriboh: !pos -43 8 82
-----------------------------------
local riverneID = zones[xi.zone.RIVERNE_SITE_A01]
local bibikiID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_SEARCH_FOR_GOLDMANE)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.SELBINA_RABAO,
    gil      = 3000,
}

quest.sections =
{
    {
        -- Quest section starting the quest and receiving the care package the care package
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.CHASING_DREAMS) and
            player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
        end,

        [xi.zone.RABAO] =
        {
            ['Zoriboh'] = quest:progressEvent(123),

            onEventFinish =
            {
                [123] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.CARE_PACKAGE)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        -- Quest stage in Tavnazia and Riverne Site A01
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Quelveuiat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(396)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(397)
                    end
                end,
            },

            onEventFinish =
            {
                [396] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_A01] =
        {
            ['Spatial_Displacement'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                            npc:getID() == riverneID.npc.GOLDMANE_DISPLACEMENT
                    then
                        return quest:progressEvent(40)
                    end
                end,
            },

            ['Trunk'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:messageSpecial(riverneID.text.TRUNK_EXAMINE)
                    elseif quest:getMustZone(player) then
                        return quest:messageSpecial(riverneID.text.TRUNK_QUEST_INVESTIGATED)
                    elseif quest:getVar(player, 'Prog') >= 3 then
                        return quest:messageSpecial(riverneID.text.TRUNK_INVESTIGATION_COMPLETE)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                            npcUtil.tradeHasExactly(trade, xi.item.COPPER_KEY)
                    then
                        return quest:progressEvent(41)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [41] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    player:tradeComplete()
                    quest:setMustZone(player)
                end,
            },
        },
    },

    {
        -- Quest stage in Bastok Purgonorgo Isle
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog >= 3
        end,

        [xi.zone.METALWORKS] =
        {
            ['Vladinek'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(887)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(888)
                    end
                end,
            },

            onEventFinish =
            {
                [887] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['Weathered_Boat'] =
            {
                onTrigger = function(player, npc)
                    if os.time() >= npc:getLocalVar('Wait') then
                        if quest:getVar(player, 'Prog') == 4 then
                            return quest:progressEvent(40)
                        elseif quest:getVar(player, 'Prog') == 5 then
                            npc:setLocalVar('QuestPlayer', player:getID())
                            npcUtil.popFromQM(player, npc, bibikiID.mob.ROHEMOLIPAUD_OFFSET, { claim = true, hide = 0 })
                            return quest:messageSpecial(bibikiID.text.FIGHT_FOR_YOUR_LIFE)
                        end
                    elseif quest:getVar(player, 'Prog') == 6 then
                        return quest:progressEvent(37)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    local mob = bibikiID.mob.ROHEMOLIPAUD_OFFSET
                    local boat = bibikiID.npc.WEATHERED_BOAT_OFFSET
                    if not GetMobByID(mob):isSpawned() then
                        SpawnMob(mob):updateClaim(player)
                        player:messageSpecial(bibikiID.text.FIGHT_FOR_YOUR_LIFE)
                        boat:setLocalVar('QuestPlayer', player:getID())
                    end
                end,

                [37] = function(player, csid, option, npc)
                    -- Only grants title if the player accepts the apprentice.
                    if option == 1 then
                        player:addTitle(xi.title.ROOKIE_HERO_INSTRUCTOR)
                    end

                    npcUtil.giveItem(player, xi.item.DELUXE_CARBINE)
                    quest:setVar(player, 'Prog', 7)
                end,
            },
        },

        [xi.zone.RABAO] =
        {
            ['Zoriboh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 7 then
                        return quest:progressEvent(128)
                    end
                end,
            },

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        -- Quest section after the player has completed the quest.
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        -- Post Quest Dialogue, Trunk in Riverne Site A01 has a dialogue change after the player has completed the quest.
        [xi.zone.RIVERNE_SITE_A01] =
        {
            ['Trunk'] =
            {
                onTrigger = function(player, npc)
                    quest:messageSpecial(riverneID.text.TRUNK_INVESTIGATION_COMPLETE)
                end,
            },
        },

        -- Post Quest Dialogue, Zoriboh in Rabao has a dialogue change after the player has completed the quest.
        [xi.zone.RABAO] =
        {
            ['Zoriboh'] =
            {
                onTrigger = function(player, npc)
                    quest:event(129)
                end,
            },
        },
    },
}

return quest
