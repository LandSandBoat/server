-----------------------------------
-- Songbirds in a Snowstorm
-----------------------------------
-- !addquest 7 51
-- Rholont            : !pos -168 -2 56 80
-- Daigraffeaux       : !pos -7 2 -89 80
-- Colossal Footprint : !pos 82.144 -19.038 139.249 136
-- Rocky Perch        : !pos -106.321 0.282 -365.035 136
-- Charred Firewood   : !pos 83.296 -58.472 175.2 136
-- Compressed Snow    : !pos 46.437 -0.762 -370.178 136
-----------------------------------
local pastBeaucedineID = zones[xi.zone.BEAUCEDINE_GLACIER_S]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SONGBIRDS_IN_A_SNOWSTORM)

quest.reward =
{
    item  = xi.item.ICARUS_WING,
}

-- NOTE: For fishing up the required Key Items, capture was accomplished with 0 skill, and the
-- award message follows the format: <playername> obtained a <keyitem>!

-- During capture, a Lu Shang rod was used with 0 skill at the specific ponds.  All three key
-- items were obtained on the first attempt.  Minigame acted like a small fish (highly active),
-- and depleted stamina within ~5 seconds of playing.

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BONDS_THAT_NEVER_DIE) and
                player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_WILL_OF_THE_WORLD)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        local questProgress = quest:getVar(player, 'Prog')

                        if questProgress == 0 then
                            return quest:progressEvent(113)
                        elseif questProgress == 1 then
                            if quest:getVar(player, 'Option') == 0 then
                                return quest:progressEvent(655)
                            else
                                return quest:event(49)
                            end
                        end
                    end
                end,
            },

            ['Daigraffeaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(114)
                    end
                end,
            },

            onEventFinish =
            {
                [113] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [114] = function(player, csid, option, npc)
                    -- TODO: Decline option and followup needs to be captured.  Given that the event option
                    -- returned for either selection is 0, operating under the assumption that this quest
                    -- will be added regardless.

                    quest:begin(player)
                end,

                [655] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
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
            ['Rholont'] = quest:event(656),
        },

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            ['Charred_Firewood'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.FLINT_STONE) and
                        quest:getVar(player, 'Prog') == 4
                    then
                        return quest:progressEvent(4)
                    end
                end,
            },

            ['Colossal_Footprint'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.LANCE_FISH) and
                        player:hasKeyItem(xi.ki.PALADIN_LOBSTER) and
                        player:hasKeyItem(xi.ki.SCUTUM_CRAB)
                    then
                        return quest:progressEvent(3, 136)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(2)
                    end
                end,
            },

            ['Compressed_Snow'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 5 then
                        return quest:progressEvent(5)
                    elseif
                        questProgress == 6 and
                        not GetMobByID(pastBeaucedineID.mob.ORCISH_BLOODLETTER):isSpawned()
                    then
                        return quest:progressEvent(27)
                    elseif questProgress == 7 then
                        return quest:progressEvent(6)
                    end
                end,
            },

            ['Orcish_Bloodletter'] =
            {
                -- TODO: Orcish Bloodletter needs verification and implementation to ensure accuracy.  Currently
                -- is set to a very high level.

                onMobDeath = function(mob, player, optParams)
                    quest:setVar(player, 'Prog', 7)
                end,
            },

            ['Rocky_Perch'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        player:messageSpecial(pastBeaucedineID.text.NONDESCRIPT_MASS)
                        npcUtil.giveItem(player, xi.item.GOLIATH_WORM)

                        return quest:noAction()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 1 then
                        return 1
                    end
                end,
            },

            onEventUpdate =
            {
                [1] = function(player, csid, option, npc)
                    if option == 11 then
                        player:updateEvent(0, 23, 1756, 0, 0, 5832718, 0, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [6] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [27] = function(player, csid, option, npc)
                    SpawnMob(pastBeaucedineID.mob.ORCISH_BLOODLETTER):updateClaim(player)
                end,
            },
        },
    },
}

return quest
