-----------------------------------
-- Dancers in Distress
-- Wings of the Goddess Mission 9
-----------------------------------
-- !addmission 5 8
-- Raustigne          : !pos 3.979 -1.999 44.456 80
-- Elegant_Footprints : !pos 46.387 0.117 318.210 82
-- LYNX_MEAT          : !additem 5667
-- GOLD_BEASTCOIN     : !additem 748
-- NYUMOMO_DOLL       : !additem 1706
-----------------------------------
local pastJugnerID = zones[xi.zone.JUGNER_FOREST_S]
local sandoriaSID  = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.DANCERS_IN_DISTRESS)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.DAUGHTER_OF_A_KNIGHT },
}

local quizItems =
{
    xi.item.LYNX_MEAT,
    xi.item.GOLD_BEASTCOIN,
    xi.item.NYUMOMO_DOLL,
}

mission.sections =
{
    -- 0: Talk to Raustigne
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:messageSpecial(sandoriaSID.text.CONCERNED_FOR_WOUNDED),

            ['Raustigne'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    -- Observed (San d'Oria, DNC Main) : 1, 3, 1, 0, 0, 0, 0, 0

                    return mission:progressEvent(86, player:getCampaignAllegiance(), 10, 1, 1, 3, 4, 8, 3)
                end,
            },

            onEventFinish =
            {
                [86] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 1: Talk to Elegant Footprints and fake quiz
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Elegant_Footprints'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(2) -- Check for params, you should join our dance troupe
                end,
            },

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    -- NOTE: The options chosen in the quiz are sequential
                    -- Page 1 updates the CS with options 1, 2 or 3, depending on what you choose
                    -- Page 2 updates the CS with options 4, 5 or 6, depending on what you choose
                    -- etc. all the way up to 18.
                    -- 19 is the end of the quiz.
                    -- The last argument is the chosen item (chosen randomly here):
                    -- 1: Lynx Meat
                    -- 2: Gold Beastcoin
                    -- 3: Doll

                    if option == 19 then
                        local randomChoice = math.random(1, 3)
                        mission:setVar(player, 'Option', randomChoice)
                        player:updateEvent(0, 0, 0, 0, 0, 0, 0, randomChoice)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    mission:setMustZone(player)
                end,
            },
        },
    },

    -- 2: Hand in quiz item
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Elegant_Footprints'] =
            {
                onTrade = function(player, npc, trade)
                    local chosenItemIndex = mission:getVar(player, 'Option')

                    if
                        not mission:getMustZone(player) and
                        npcUtil.tradeHasExactly(trade, quizItems[chosenItemIndex])
                    then
                        return mission:progressEvent(3, 0, 0, 0, 0, 0, 0, 0, chosenItemIndex)
                    end
                end,

                onTrigger = function(player, npc)
                    local chosenItemIndex = mission:getVar(player, 'Option')

                    return mission:messageSpecial(pastJugnerID.text.LILISETTE_IS_PREPARING, quizItems[chosenItemIndex])
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return mission
