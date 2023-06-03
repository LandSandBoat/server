-----------------------------------
-- Crafted Dancer Artifact
-- Olgald   : !pos -53.072 -1 103.380 244
-- Matthias : !pos -114.1 -4.29 -107.28 235
-----------------------------------
-- Variable Notes:
-- * Prog   - Overall completion progress
-- * Option - Selected Artifact
-- * Status - Remaining Artifact Bitmask (0 = Completed)
-- * Timer  - VanadielUniqueDay Wait Timer
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------

local quest = HiddenQuest:new("DncArtifact")

local dncArtifactOptions =
{
    [1] = { xi.items.DANCERS_TIARA_F,     { xi.items.SQUARE_OF_IMPERIAL_SILK_CLOTH, xi.items.SQUARE_OF_WOLF_FELT,     xi.items.SQUARE_OF_SILVER_BROCADE }, },
    [2] = { xi.items.DANCERS_BANGLES_F,   { xi.items.SQUARE_OF_KARAKUL_CLOTH,       xi.items.SQUARE_OF_RAINBOW_CLOTH, xi.items.SQUARE_OF_RAINBOW_VELVET }, },
    [3] = { xi.items.DANCERS_TOE_SHOES_F, { xi.items.SQUARE_OF_WAMOURA_CLOTH,       xi.items.SQUARE_OF_MOBLINWEAVE,   xi.items.SQUARE_OF_GOLD_BROCADE   }, },
}

quest.sections =
{
    -- Common Functions and Beginning Quest.  Note: Progress variable is set on completion of Road to Divadom in
    -- order to prevent needing a forever CharVar.
    {
        check = function(player, questVars, vars)
            return player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM) and
                player:getMainJob() == xi.job.DNC
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Olgald'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(10167)
                    elseif questProgress == 2 then
                        return quest:event(10168):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [10167] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Status', 7)
                end,
            },
        },
    },

    -- Equivalent of Accepted.  If Status == 0, then there is no remaining Artifact to be quested, and
    -- we can treat as Completed.
    {
        check = function(player, questVars, vars)
            return questVars.Prog > 0 and
                questVars.Status > 0 and
                player:getMainJob() == xi.job.DNC
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Matthias'] =
            {
                onTrade = function(player, npc, trade)
                    local selectedArtifact = quest:getVar(player, 'Option')

                    if
                        quest:getVar(player, 'Prog') == 4 and
                        npcUtil.tradeHasExactly(trade, dncArtifactOptions[selectedArtifact][2])
                    then
                        return quest:progressEvent(495, selectedArtifact - 1)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(492)
                    elseif questProgress == 3 then
                        local questStatus    = quest:getVar(player, 'Status')
                        local completedItems = { 0, 0, 0 }

                        for artifactOption = 1, 3 do
                            if not utils.mask.getBit(questStatus, artifactOption - 1) then
                                completedItems[artifactOption] = 1
                            end
                        end

                        return quest:progressEvent(493, completedItems[1], completedItems[2], completedItems[3])
                    elseif questProgress == 4 then
                        return quest:progressEvent(494, quest:getVar(player, 'Option') - 1)
                    elseif questProgress == 5 then
                        if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                            local isLastArtifact = utils.mask.countBits(quest:getVar(player, 'Status'), 3) == 1 and 1 or 0

                            return quest:progressEvent(497, dncArtifactOptions[quest:getVar(player, 'Option')][1] - player:getGender(), isLastArtifact)
                        else
                            return quest:progressEvent(496)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [492] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 3)
                    else
                        quest:setVar(player, 'Prog', 4)
                        quest:setVar(player, 'Option', option)
                    end
                end,

                [493] = function(player, csid, option, npc)
                    if option ~= 0 then
                        if utils.mask.getBit(quest:getVar(player, 'Status'), option - 1) then
                            quest:setVar(player, 'Option', option)
                            quest:setVar(player, 'Prog', 4)
                        end
                    end
                end,

                [495] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    quest:setVar(player, 'Prog', 5)
                end,

                [497] = function(player, csid, option, npc)
                    local questOption    = quest:getVar(player, 'Option')
                    local artifactItemID = dncArtifactOptions[questOption][1] - player:getGender()

                    if npcUtil.giveItem(player, artifactItemID) then
                        if utils.mask.countBits(quest:getVar(player, 'Status'), 3) == 1 then
                            quest:complete(player)
                        else
                            quest:unsetVarBit(player, 'Status', questOption - 1)
                            quest:setVar(player, 'Prog', 3)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, questVars, vars)
            return player:findItem(xi.items.DANCERS_TIARA_F - player:getGender()) and
                player:findItem(xi.items.DANCERS_BANGLES_F - player:getGender()) and
                player:findItem(xi.items.DANCERS_TOE_SHOES_F - player:getGender()) and
                player:getMainJob() == xi.job.DNC
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Matthias'] = quest:progressEvent(498),
        },
    },
}

return quest
