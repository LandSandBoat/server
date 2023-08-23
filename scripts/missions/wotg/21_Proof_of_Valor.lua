-----------------------------------
-- Proof of Valor
-- Wings of the Goddess Mission 21
-----------------------------------
-- !addmission 5 20
-- Raustigne : !pos 3.979 -1.999 44.456 80
-----------------------------------
local pastSandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.PROOF_OF_VALOR)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_SANGUINARY_PRELUDE },
}

local itemRewards =
{
    [xi.item.MOLYBDENUM_INGOT ] = 120,
    [xi.item.ORICHALCUM_INGOT ] = 100,
    [xi.item.ANGEL_SKIN_ORB   ] = 81,
    [xi.item.SQUARE_OF_FOULARD] = 41,
    [xi.item.OXBLOOD_ORB      ] = 30,
}

local orcItems =
{
    [xi.item.ORCISH_AXE  ] = 5,
    [xi.item.ORC_HELMET  ] = 10,
    [xi.item.ORC_PAULDRON] = 10,
    [xi.item.GOLD_ORCMASK] = 15,
}

local function completePetition(player, posBit, numSignatures)
    mission:setVarBit(player, 'Status', posBit)
    mission:addVar(player, 'Option', numSignatures)

    local totalSignatures = mission:getVar(player, 'Option')

    player:messageSpecial(pastSandoriaID.text.HAVE_GATHERED_SIGNATURE, xi.ki.NORTH_BOUND_PETITION, totalSignatures)
end

local function updateGameRound(player, option, correctOptions)
    local gameRound  = mission:getLocalVar(player, 'gameRound')
    local numCorrect = mission:getLocalVar(player, 'numCorrect')

    if option == #correctOptions * 3 then
        player:updateEvent(numCorrect)
    elseif option == correctOptions[gameRound] then
        mission:setLocalVar(player, 'numCorrect', numCorrect + 1)
        mission:setLocalVar(player, 'gameRound', gameRound + 1)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Raustigne'] =
            {
                onTrigger = function(player, npc)
                    local numPetitions = mission:getVar(player, 'Option')

                    if not mission:getMustZone(player) then
                        if numPetitions < 20 then
                            -- NOTE: The below messages are only displayed once per zone.
                            mission:setMustZone(player)

                            player:messageSpecial(pastSandoriaID.text.MUST_GATHER_SIGNATURES, 20)
                            return mission:messageSpecial(pastSandoriaID.text.CURRENT_PETITIONS, 0, numPetitions, xi.ki.NORTH_BOUND_PETITION)
                        else
                            return mission:progressEvent(148, player:getCampaignAllegiance(), mission:getVar(player, 'Option'))
                        end
                    end
                end,
            },

            ['Aissaville'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 0) then
                        return mission:progressEvent(123)
                    end
                end,
            },

            ['Andagge'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 2) then
                        return mission:progressEvent(121)
                    end
                end,
            },

            ['Aurfet'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 11) then
                        mission:setLocalVar(player, 'gameRound', 1)
                        mission:setLocalVar(player, 'numCorrect', 2)

                        return mission:progressEvent(127)
                    end
                end,
            },

            ['Corseihaut'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 12) then
                        mission:setLocalVar(player, 'gameRound', 1)
                        mission:setLocalVar(player, 'numCorrect', 0)

                        return mission:progressEvent(128)
                    end
                end,
            },

            ['Coucheutand'] =
            {
                onTrade = function(player, npc, trade)
                    for itemId, signatureValue in pairs(orcItems) do
                        if npcUtil.tradeHasExactly(trade, itemId) then
                            mission:setLocalVar(player, 'numSignatures', signatureValue)

                            return mission:progressEvent(136, itemId)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 15) then
                        if not mission:isVarBitsSet(player, 'Remind', 1) then
                            return mission:progressEvent(132)
                        else
                            return mission:event(142)
                        end
                    end
                end,
            },

            ['Daigraffeaux'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 3) then
                        return mission:progressEvent(118, player:getCampaignAllegiance(), 19, 6, 0, 0, 0, 8, 0)
                    end
                end,
            },

            ['Elnonde'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 6) then
                        return mission:progressEvent(116, player:getCampaignAllegiance(), 23, 2964, 32747, 1073741823, 3, 10, 0)
                    end
                end,
            },

            ['Eumielle'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.ANGLERS_CASSOULET) and
                        mission:isVarBitsSet(player, 'Remind', 0)
                    then
                        return mission:progressEvent(135)
                    end
                end,

                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 14) then
                        if not mission:isVarBitsSet(player, 'Remind', 0) then
                            return mission:progressEvent(131)
                        else
                            return mission:event(141)
                        end
                    end
                end,
            },

            ['Farouel'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 10) then
                        mission:setLocalVar(player, 'gameRound', 1)
                        mission:setLocalVar(player, 'numCorrect', 3)

                        return mission:progressEvent(125)
                    end
                end,
            },

            ['Hauberliond'] =
            {
                onTrade = function(player, npc, trade)
                    -- TODO: This may not be accurate, and may follow a similar pattern
                    -- discovered with Sabiliont.  A single crossbow bolt may be an
                    -- acceptable trade.
                    if
                        npcUtil.tradeHasOnly(trade, xi.item.CROSSBOW_BOLT) and
                        trade:getItemCount() >= 99 and
                        mission:isVarBitsSet(player, 'Remind', 2)
                    then
                        local numStacks     = math.floor(trade:getItemCount() / 99)
                        local numSignatures = math.min(12, 8 + numStacks)

                        mission:setLocalVar(player, 'numSignatures', numSignatures)

                        return mission:progressEvent(134)
                    end
                end,

                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 16) then
                        if not mission:isVarBitsSet(player, 'Remind', 2) then
                            return mission:progressEvent(130)
                        else
                            return mission:event(140)
                        end
                    end
                end,
            },

            ['Illeuse'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 1) then
                        return mission:progressEvent(115, player:getCampaignAllegiance(), 22)
                    end
                end,
            },

            ['Loillie'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 7) then
                        return mission:progressEvent(117)
                    end
                end,
            },

            ['Louxiard'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 4) then
                        return mission:progressEvent(119)
                    end
                end,
            },

            ['Machionage'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 5) then
                        return mission:progressEvent(120)
                    end
                end,
            },

            ['Mailleronce'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 9) then
                        return mission:progressEvent(122)
                    end
                end,
            },

            ['Remiotte'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 8) then
                        return mission:progressEvent(124)
                    end
                end,
            },

            ['Rongelouts_N_Distaud'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.GNOLE_CLAW) then
                        return mission:progressEvent(144)
                    end
                end,

                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 18) then
                        if mission:getVar(player, 'Prog') == 0 then
                            if not mission:isVarBitsSet(player, 'Remind', 4) then
                                return mission:progressEvent(137)
                            else
                                return mission:event(143):oncePerZone()
                            end
                        else
                            return mission:progressEvent(138, 80, 60)
                        end
                    else
                        return mission:event(150):oncePerZone()
                    end
                end,
            },

            ['Sabiliont'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasOnly(trade, xi.item.BUNCH_OF_GYSAHL_GREENS) and
                        mission:isVarBitsSet(player, 'Remind', 3)
                    then
                        -- TODO: This formula is estimated; however, a trade of a single gysahl green
                        -- awards 5 signatures.  While not aligning with Wiki, adding a bonus to that
                        -- base value for each full stack to that.
                        local numStacks     = math.floor(trade:getItemCount() / 99)
                        local numSignatures = math.min(12, 5 + numStacks)

                        mission:setLocalVar(player, 'numSignatures', numSignatures)

                        return mission:progressEvent(133)
                    end
                end,

                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 17) then
                        if not mission:isVarBitsSet(player, 'Remind', 3) then
                            return mission:progressEvent(129)
                        else
                            return mission:event(139)
                        end
                    end
                end,
            },

            ['Vichauxdat'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 13) then
                        mission:setLocalVar(player, 'gameRound', 1)
                        mission:setLocalVar(player, 'numCorrect', 3)

                        return mission:progressEvent(126)
                    end
                end,
            },

            onEventUpdate =
            {
                [125] = function(player, csid, option, npc)
                    -- NOTE: There are other options that may be considered valid in this event.
                    updateGameRound(player, option, { 1, 4, 8 })
                end,

                [126] = function(player, csid, option, npc)
                    updateGameRound(player, option, { 1, 4, 6 })
                end,

                [127] = function(player, csid, option, npc)
                    updateGameRound(player, option, { 1, 5, 7, 10 })
                end,

                [128] = function(player, csid, option, npc)
                    updateGameRound(player, option, { 2, 5, 6, 11, 13, 16 })
                end,
            },

            onEventFinish =
            {
                [115] = function(player, csid, option, npc)
                    completePetition(player, 1, 1)
                end,

                [116] = function(player, csid, option, npc)
                    completePetition(player, 6, 1)
                end,

                [117] = function(player, csid, option, npc)
                    completePetition(player, 7, 1)
                end,

                [118] = function(player, csid, option, npc)
                    completePetition(player, 3, 1)
                end,

                [119] = function(player, csid, option, npc)
                    completePetition(player, 4, 1)
                end,

                [120] = function(player, csid, option, npc)
                    completePetition(player, 5, 1)
                end,

                [121] = function(player, csid, option, npc)
                    completePetition(player, 2, 1)
                end,

                [122] = function(player, csid, option, npc)
                    completePetition(player, 9, 1)
                end,

                [123] = function(player, csid, option, npc)
                    completePetition(player, 0, 1)
                end,

                [124] = function(player, csid, option, npc)
                    completePetition(player, 8, 1)
                end,

                [125] = function(player, csid, option, npc)
                    if option == 1 then
                        local numSignatures = mission:getVar(player, 'numCorrect')
                        completePetition(player, 10, numSignatures)
                    end
                end,

                [126] = function(player, csid, option, npc)
                    if option == 1 then
                        local numSignatures = mission:getVar(player, 'numCorrect')
                        completePetition(player, 13, numSignatures)
                    end
                end,

                [127] = function(player, csid, option, npc)
                    if option == 1 then
                        local numSignatures = mission:getVar(player, 'numCorrect')
                        completePetition(player, 11, numSignatures)
                    end
                end,

                [128] = function(player, csid, option, npc)
                    if option == 1 then
                        local numSignatures = mission:getVar(player, 'numCorrect')
                        completePetition(player, 12, numSignatures)
                    end
                end,

                [129] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Remind', 3)
                end,

                [130] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Remind', 2)
                end,

                [131] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Remind', 0)
                end,

                [132] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Remind', 1)
                end,

                [133] = function(player, csid, option, npc)
                    player:confirmTrade()

                    local numSignatures = mission:getLocalVar(player, 'numSignatures')
                    completePetition(player, 17, numSignatures)
                end,

                [134] = function(player, csid, option, npc)
                    player:confirmTrade()

                    local numSignatures = mission:getLocalVar(player, 'numSignatures')
                    completePetition(player, 16, numSignatures)
                end,

                [135] = function(player, csid, option, npc)
                    player:confirmTrade()
                    completePetition(player, 14, 12)
                end,

                [136] = function(player, csid, option, npc)
                    player:confirmTrade()

                    local numSignatures = mission:getLocalVar(player, 'numSignatures')
                    completePetition(player, 15, numSignatures)
                end,

                [137] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Remind', 4)
                end,

                [138] = function(player, csid, option, npc)
                    if option == 1 then
                        completePetition(player, 18, 35)
                    end
                end,

                [144] = function(player, csid, option, npc)
                    player:confirmTrade()

                    if option == 1 then
                        completePetition(player, 18, 35)
                    else
                        mission:setVar(player, 'Prog', 1)
                    end
                end,

                [148] = function(player, csid, option, npc)
                    if option == 1 then
                        local numSignatures = mission:getVar(player, 'Option')
                        local rewardItemId  = nil

                        for itemId, requiredSignatures in pairs(itemRewards) do
                            if numSignatures >= requiredSignatures then
                                rewardItemId = itemId
                                break
                            end
                        end

                        if
                            rewardItemId == nil or
                            npcUtil.giveItem(player, rewardItemId)
                        then
                            mission:complete(player)
                        end
                    else
                        mission:setMustZone(player)
                    end
                end,
            },
        },
    },
}

return mission
