-----------------------------------
-- Helpers for Jeuno quests
-----------------------------------
xi = xi or {}
xi.jeuno = xi.jeuno or {}
xi.jeuno.helpers = xi.jeuno.helpers or {}

-- Base class for use by the Gobbiebag questline to reduce redundant code.
-- The quests differ slightly in requested items, inventory size key, text, etc.
-- The params parameter stores the tunable information needed to perform the proper quest in the chain.
xi.jeuno.helpers.GobbiebagQuest = {}

setmetatable(xi.jeuno.helpers.GobbiebagQuest, { __index = Quest })
xi.jeuno.helpers.GobbiebagQuest.__index = xi.jeuno.helpers.GobbiebagQuest

function xi.jeuno.helpers.GobbiebagQuest:new(params)
    local quest = Quest:new(xi.questLog.JEUNO, params.questId)

    quest.reward = params.reward

    local bagIncrease = 5

    -- If quest is available or accepted, the correct dialogue ID is the expected pre quest inventory size offset by 1
    local getPendingDialogueId = function(player)
        return (player:getContainerSize(xi.inv.INVENTORY) + 1)
    end

    -- If quest is completed, the correct dialogue ID is the expected post quest inventory size offset by 1
    local getCompleteDiaglogueId = function(player)
        return (player:getContainerSize(xi.inv.INVENTORY) + bagIncrease + 1)
    end

    local getReqsMet = function(player)
        return  player:getFameLevel(xi.fameArea.JEUNO) >= params.fame and
                player:getContainerSize(xi.inv.INVENTORY) == params.startInventorySize and
                (params.prerequisite == nil or player:hasCompletedQuest(xi.questLog.JEUNO, params.prerequisite))
    end

    quest.sections =
    {
        {
            check = function(player, status, vars)
                return status == xi.questStatus.QUEST_AVAILABLE and getReqsMet(player)
            end,

            [xi.zone.LOWER_JEUNO] =
            {
                ['Bluffnix'] =
                {
                    onTrigger = function(player, npc)
                        return quest:progressEvent(43, getPendingDialogueId(player), xi.questStatus.QUEST_AVAILABLE, getReqsMet(player) and 1 or 0)
                    end
                },

                onEventFinish =
                {
                    [43] = function(player, csid, option, npc)
                        if option == 0 then
                            quest:begin(player)
                        end
                    end
                },
            },
        },

        {
            check = function(player, status, vars)
                return status == xi.questStatus.QUEST_ACCEPTED and getReqsMet(player)
            end,

            [xi.zone.LOWER_JEUNO] =
            {
                ['Bluffnix'] =
                {
                    onTrade = function(player, npc, trade)
                        if
                            npcUtil.tradeHasExactly(trade, params.tradeItems) or
                            npcUtil.tradeHasExactly(trade, params.tradeStew)
                        then
                            return quest:progressEvent(73, getCompleteDiaglogueId(player))
                        else
                            return quest:progressEvent(43, getPendingDialogueId(player), xi.questStatus.QUEST_ACCEPTED, 1)
                        end
                    end,

                    onTrigger = function(player, npc)
                        return quest:progressEvent(43, getPendingDialogueId(player), xi.questStatus.QUEST_ACCEPTED, 1)
                    end,
                },

                onEventFinish =
                {
                    [73] = function(player, csid, option, npc)
                        if quest:complete(player) then
                            player:changeContainerSize(xi.inv.INVENTORY, bagIncrease)
                            player:changeContainerSize(xi.inv.MOGSATCHEL, bagIncrease)
                            player:messageSpecial(params.message)
                            player:confirmTrade()
                        end
                    end
                },
            },
        },
    }

    self.__index = self
    setmetatable(quest, self)
    return quest
end

-- Base class for use by the Zalsuhm unlocking a myth quests to reduce redundant code.
-- The quests differ only in job matching the weapon
xi.jeuno.helpers.UnlockingAMyth = {}

setmetatable(xi.jeuno.helpers.UnlockingAMyth, { __index = Quest })
xi.jeuno.helpers.UnlockingAMyth.__index = xi.jeuno.helpers.UnlockingAMyth

function xi.jeuno.helpers.UnlockingAMyth:new(jobId)
    -- wsId is unused, but useful data for testing/sanity
    local vigilWeaponsData =
    {
        [xi.job.WAR] =
        {
            itemId = xi.item.STURDY_AXE, -- (WAR)
            wsUnlockId = xi.wsUnlock.KINGS_JUSTICE,
            wsId = xi.weaponskill.KINGS_JUSTICE,
        },
        [xi.job.MNK] =
        {
            itemId = xi.item.BURNING_FISTS, -- (MNK)
            wsUnlockId = xi.wsUnlock.ASCETICS_FURY,
            wsId = xi.weaponskill.ASCETICS_FURY,
        },
        [xi.job.WHM] =
        {
            itemId = xi.item.WEREBUSTER, -- (WHM)
            wsUnlockId = xi.wsUnlock.MYSTIC_BOON,
            wsId = xi.weaponskill.MYSTIC_BOON,
        },
        [xi.job.BLM] =
        {
            itemId = xi.item.MAGES_STAFF, -- (BLM)
            wsUnlockId = xi.wsUnlock.VIDOHUNIR,
            wsId = xi.weaponskill.VIDOHUNIR,
        },
        [xi.job.RDM] =
        {
            itemId = xi.item.VORPAL_SWORD, -- (RDM)
            wsUnlockId = xi.wsUnlock.DEATH_BLOSSOM,
            wsId = xi.weaponskill.DEATH_BLOSSOM,
        },
        [xi.job.THF] =
        {
            itemId = xi.item.SWORDBREAKER, -- (THF)
            wsUnlockId = xi.wsUnlock.MANDALIC_STAB,
            wsId = xi.weaponskill.MANDALIC_STAB,
        },
        [xi.job.PLD] =
        {
            itemId = xi.item.BRAVE_BLADE, -- (PLD)
            wsUnlockId = xi.wsUnlock.ATONEMENT,
            wsId = xi.weaponskill.ATONEMENT,
        },
        [xi.job.DRK] =
        {
            itemId = xi.item.DEATH_SICKLE, -- (DRK)
            wsUnlockId = xi.wsUnlock.INSURGENCY,
            wsId = xi.weaponskill.INSURGENCY,
        },
        [xi.job.BST] =
        {
            itemId = xi.item.DOUBLE_AXE, -- (BST)
            wsUnlockId = xi.wsUnlock.PRIMAL_REND,
            wsId = xi.weaponskill.PRIMAL_REND,
        },
        [xi.job.BRD] =
        {
            itemId = xi.item.DANCING_DAGGER, -- (BRD)
            wsUnlockId = xi.wsUnlock.MORDANT_RIME,
            wsId = xi.weaponskill.MORDANT_RIME,
        },
        [xi.job.RNG] =
        {
            itemId = xi.item.KILLER_BOW, -- (RNG)
            wsUnlockId = xi.wsUnlock.TRUEFLIGHT,
            wsId = xi.weaponskill.TRUEFLIGHT,
        },
        [xi.job.SAM] =
        {
            itemId = xi.item.WINDSLICER, -- (SAM)
            wsUnlockId = xi.wsUnlock.TACHI_RANA,
            wsId = xi.weaponskill.TACHI_RANA,
        },
        [xi.job.NIN] =
        {
            itemId = xi.item.SASUKE_KATANA, -- (NIN)
            wsUnlockId = xi.wsUnlock.BLADE_KAMU,
            wsId = xi.weaponskill.BLADE_KAMU,
        },
        [xi.job.DRG] =
        {
            itemId = xi.item.RADIANT_LANCE, -- (DRG)
            wsUnlockId = xi.wsUnlock.DRAKESBANE,
            wsId = xi.weaponskill.DRAKESBANE,
        },
        [xi.job.SMN] =
        {
            itemId = xi.item.SCEPTER_STAFF, -- (SMN)
            wsUnlockId = xi.wsUnlock.GARLAND_OF_BLISS,
            wsId = xi.weaponskill.GARLAND_OF_BLISS,
        },
        [xi.job.BLU] =
        {
            itemId = xi.item.WIGHTSLAYER, -- (BLU)
            wsUnlockId = xi.wsUnlock.EXPIACION,
            wsId = xi.weaponskill.EXPIACION,
        },
        [xi.job.COR] =
        {
            itemId = xi.item.QUICKSILVER, -- (COR)
            wsUnlockId = xi.wsUnlock.LEADEN_SALUTE,
            wsId = xi.weaponskill.LEADEN_SALUTE,
        },
        [xi.job.PUP] =
        {
            itemId = xi.item.INFERNO_CLAWS, -- (PUP)
            wsUnlockId = xi.wsUnlock.STRINGING_PUMMEL,
            wsId = xi.weaponskill.STRINGING_PUMMEL,
        },
        [xi.job.DNC] =
        {
            itemId = xi.item.MAIN_GAUCHE, -- (DNC)
            wsUnlockId = xi.wsUnlock.PYRRHIC_KLEOS,
            wsId = xi.weaponskill.PYRRHIC_KLEOS,
        },
        [xi.job.SCH] =
        {
            itemId = xi.item.ELDER_STAFF, -- (SCH)
            wsUnlockId = xi.wsUnlock.OMNISCIENCE,
            wsId = xi.weaponskill.OMNISCIENCE,
        },
    }

    local questId    = xi.quest.id.jeuno.UNLOCKING_A_MYTH_WARRIOR - 1 + jobId
    local weaponData = vigilWeaponsData[jobId]

    local quest = Quest:new(xi.questLog.JEUNO, questId)

    quest.sections =
    {
        {
            check = function(player, status, vars)
                -- quest can be flagged multiple times for different jobs, no need for additional check here
                -- https://www.ffxiah.com/forum/topic/11987/cancel-unlocking-a-myth-quest
                return player:getMainJob() == jobId and status == xi.questStatus.QUEST_AVAILABLE
            end,

            [xi.zone.LOWER_JEUNO] =
            {
                ['Zalsuhm'] =
                {
                    onTrigger = function(player, npc)
                        -- Must be wearing one of the weapons in the primary slot to flag the quest
                        local weaponMain      = player:getEquipID(xi.slot.MAIN)
                        local weaponRanged    = player:getEquipID(xi.slot.RANGED)
                        local isWearingWeapon = weaponMain == weaponData.itemId or weaponRanged == weaponData.itemId
                        local upsetZalsuhm    = quest:getVar(player, 'Upset_Zalsuhm') > 0

                        if player:needToZone() and upsetZalsuhm then
                            return quest:progressEvent(10090)
                        else
                            if upsetZalsuhm then
                                quest:setVar(player, 'Upset_Zalsuhm', 0)
                            end

                            if isWearingWeapon then
                                return quest:progressEvent(10086, jobId)
                            else
                                return quest:progressEvent(10085)
                            end
                        end
                    end
                },

                onEventFinish =
                {
                    [10086] = function(player, csid, option, npc)
                        if option == 53 then
                            quest:setVar(player, 'Upset_Zalsuhm', 1)
                            player:needToZone(true)
                        elseif option == jobId then
                            quest:begin(player)
                        end
                    end,
                },
            },
        },

        {
            check = function(player, status, vars)
                return player:getMainJob() == jobId and status == xi.questStatus.QUEST_ACCEPTED
            end,

            [xi.zone.LOWER_JEUNO] =
            {
                ['Zalsuhm'] =
                {
                    onTrade = function(player, npc, trade)
                        -- TODO is there a message for trading anything else?
                        if npcUtil.tradeHasExactly(trade, weaponData.itemId) then
                            local requiredWsPoints = xi.equipment.vigilWeaponRequiredWsPoints(player)
                            local wsPoints = trade:getItem(0):getWeaponskillPoints()

                            if wsPoints <= requiredWsPoints / 5 then
                                return quest:event(10091)
                            elseif wsPoints <= requiredWsPoints * 4 / 5 then
                                return quest:event(10092)
                            elseif wsPoints < requiredWsPoints then
                                return quest:event(10093)
                            elseif wsPoints >= requiredWsPoints then
                                return quest:progressEvent(10088, jobId)
                            end
                        end
                    end,

                    onTrigger = function(player, npc)
                        return quest:cutscene(10087)
                    end,
                },

                onEventFinish =
                {
                    [10088] = function(player, csid, option, npc)
                        if quest:complete(player) then
                            player:messageSpecial(zones[player:getZoneID()].text.MYTHIC_LEARNED, jobId)
                            player:addLearnedWeaponskill(weaponData.wsUnlockId)
                            -- player keeps vigil weapon
                        end
                    end,
                },
            },
        },
    }

    self.__index = self
    setmetatable(quest, self)
    return quest
end

-- Base class for use by the Gobbiebag questline to reduce redundant code.
-- The quests differ slightly in requested items, inventory size key, text, etc.
-- The params parameter stores the tunable information needed to perform the proper quest in the chain.
xi.jeuno.helpers.BorghertzQuests = {}

setmetatable(xi.jeuno.helpers.BorghertzQuests, { __index = Quest })
xi.jeuno.helpers.BorghertzQuests.__index = xi.jeuno.helpers.BorghertzQuests

function xi.jeuno.helpers.BorghertzQuests:new(params)
    local quest = Quest:new(xi.questLog.JEUNO, params.questId)

    local borghertzQuests =
    {
        xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_STRIKING_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_HEALING_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_SORCEROUS_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_VERMILLION_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_SNEAKY_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_STALWART_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_SHADOWY_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_WILD_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_HARMONIOUS_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_CHASING_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_LOYAL_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_LURKING_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_DRAGON_HANDS,
        xi.quest.id.jeuno.BORGHERTZS_CALLING_HANDS,
    }

    local function canStartQuest(player)
        -- Previous quest check.
        if player:getQuestStatus(params.requiredLogId, params.requiredQuestId) == xi.questStatus.QUEST_AVAILABLE then
            return false
        end

        -- Job check.
        if player:getMainJob() ~= params.requiredJobId then
            return false
        end

        -- Level check.
        if player:getMainLvl() < 50 then
            return false
        end

        -- Any other Borghertz quest check.
        for i = 1, #borghertzQuests do
            if player:getQuestStatus(xi.questLog.JEUNO, borghertzQuests[i]) == xi.questStatus.QUEST_ACCEPTED then
                return false
            end
        end

        return true
    end

    local function isFirstBorghertzQuest(player)
        for i = 1, #borghertzQuests do
            if player:getQuestStatus(xi.questLog.JEUNO, borghertzQuests[i]) == xi.questStatus.QUEST_COMPLETED then
                return false
            end
        end

        return true
    end

    quest.reward =
    {
        item = params.handAFId,
    }

    quest.sections =
    {
        {
            check = function(player, status, vars)
                return status == xi.questStatus.QUEST_AVAILABLE
            end,

            [xi.zone.UPPER_JEUNO] =
            {
                ['Guslam'] =
                {
                    onTrigger = function(player, npc)
                        if canStartQuest(player) then
                            return quest:progressEvent(155)
                        end
                    end,
                },

                onEventFinish =
                {
                    [155] = function(player, csid, option, npc)
                        quest:begin(player)
                    end,
                },
            },
        },

        {
            check = function(player, status, vars)
                return status == xi.questStatus.QUEST_ACCEPTED
            end,

            [xi.zone.CASTLE_ZVAHL_BAILEYS] =
            {
                ['Dark_Spark'] =
                {
                    onMobDeath = function(mob, player, optParams)
                        if quest:getVar(player, 'Prog') == 4 then
                            quest:setVar(player, 'Prog', 5)
                        end
                    end,
                },

                ['Torch'] =
                {
                    onTrigger = function(player, npc)
                        local questProgress = quest:getVar(player, 'Prog')

                        if
                            questProgress == 4 and
                            npcUtil.popFromQM(player, npc, zones[xi.zone.CASTLE_ZVAHL_BAILEYS].mob.DARK_SPARK, { claim = true, hide = 0 })
                        then
                            return quest:messageSpecial(zones[xi.zone.CASTLE_ZVAHL_BAILEYS].text.SENSE_OF_FOREBODING)
                        elseif
                            questProgress == 5 and
                            not player:hasKeyItem(xi.keyItem.SHADOW_FLAMES)
                        then
                            npcUtil.giveKeyItem(player, xi.keyItem.SHADOW_FLAMES)
                            return quest:noAction()
                        end
                    end,
                },
            },

            [xi.zone.LOWER_JEUNO] =
            {
                ['Yin_Pocanakhu'] =
                {
                    onTrigger = function(player, npc)
                        if quest:getVar(player, 'Prog') == 2 then
                            return quest:progressEvent(220)
                        end
                    end,
                },

                onEventUpdate =
                {
                    [220] = function(player, csid, option, npc)
                        if player:getGil() >= 1000 then
                            player:delGil(1000)
                            quest:setVar(player, 'Prog', 3) -- Spoken with Yin Pocanakhu.
                            player:updateEvent(1)
                        end
                    end,
                },
            },

            [xi.zone.PORT_JEUNO] =
            {
                ['qm1'] =
                {
                    onTrigger = function(player, npc)
                        local questProgress = quest:getVar(player, 'Prog')

                        if questProgress == 3 then
                            return quest:progressEvent(20)
                        elseif questProgress >= 4 and not player:hasKeyItem(xi.keyItem.SHADOW_FLAMES) then
                            return quest:event(49)
                        elseif questProgress == 5 and player:hasKeyItem(xi.keyItem.SHADOW_FLAMES) then
                            return quest:progressEvent(48)
                        end
                    end,
                },

                onEventFinish =
                {
                    [20] = function(player, csid, option, npc)
                        if option == 1 then
                            quest:setVar(player, 'Prog', 4) -- Spoken with Borghertz. Requested "Shadow Flames".
                        end
                    end,

                    [48] = function(player, csid, option, npc)
                        if quest:complete(player) then
                            player:delKeyItem(xi.keyItem.OLD_GAUNTLETS)
                            player:delKeyItem(xi.keyItem.SHADOW_FLAMES)
                        end
                    end,
                },
            },

            [xi.zone.UPPER_JEUNO] =
            {
                ['Deadly_Minnow'] =
                {
                    onTrigger = function(player, npc)
                        if quest:getVar(player, 'Prog') == 1 then
                            return quest:progressEvent(24)
                        end
                    end,
                },

                ['Guslam'] =
                {
                    onTrigger = function(player, npc)
                        if player:hasKeyItem(xi.keyItem.OLD_GAUNTLETS) then
                            return quest:progressEvent(26)
                        else
                            return quest:event(43)
                        end
                    end,
                },

                onEventFinish =
                {
                    [24] = function(player, csid, option, npc)
                        quest:setVar(player, 'Prog', 2) -- Spoken with deadly Minnow.
                    end,

                    [26] = function(player, csid, option, npc)
                        if quest:getVar(player, 'Prog') == 0 then
                            if isFirstBorghertzQuest(player) then
                                quest:setVar(player, 'Prog', 1) -- Speak with Deadly Minnow and Yin Pocanakhu.
                            else
                                quest:setVar(player, 'Prog', 3) -- Skip intermediaries.
                            end
                        end
                    end,
                },
            },

            -- Old gauntlets coffer logic.
            [params.oldGauntletZoneId] =
            {
                ['Treasure_Coffer'] =
                {
                    onTrade = function(player, npc, trade)
                        if not player:hasKeyItem(xi.keyItem.OLD_GAUNTLETS) then
                            xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.OLD_GAUNTLETS)

                            return quest:noAction()
                        end
                    end,
                },
            },
        },

        {
            check = function(player, status, vars)
                return status ~= xi.questStatus.QUEST_AVAILABLE and
                    player:getMainJob() == params.requiredJobId
            end,

            [params.optionalZoneId1] =
            {
                ['Treasure_Coffer'] =
                {
                    onTrade = function(player, npc, trade)
                        if not player:hasItem(params.optionalArtifact1) then
                            xi.treasure.onTrade(player, npc, trade, 1, params.optionalArtifact1)

                            return quest:noAction()
                        end
                    end,
                },
            },

            [params.optionalZoneId2] =
            {
                ['Treasure_Coffer'] =
                {
                    onTrade = function(player, npc, trade)
                        if not player:hasItem(params.optionalArtifact2) then
                            xi.treasure.onTrade(player, npc, trade, 1, params.optionalArtifact2)

                            return quest:noAction()
                        end
                    end,
                },
            },
        },
    }

    self.__index = self
    setmetatable(quest, self)
    return quest
end
