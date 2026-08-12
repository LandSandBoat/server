-----------------------------------
-- The Road to Aht Urhgan
-----------------------------------
-- Log ID: 3, Quest ID: 91
-- Faursel : !pos 37.985 3.118 -45.208 245
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_AHT_URHGAN)

quest.reward =
{
}

local beginnerList =
{
    { xi.item.DAMSELFLY_WORM,        1 },
    { xi.item.MAGICKED_SKULL,        1 },
    { xi.item.CRAB_APRON,            1 },
    { xi.item.BLOODY_ROBE,           1 },
    { xi.item.CUP_OF_DHALMEL_SALIVA, 1 },
    { xi.item.WILD_RABBIT_TAIL,      1 },
}

local intermediateList =
{
    { xi.item.JADE_CRYPTEX,        1 },
    { xi.item.SILVER_ENGRAVING,    1 },
    { xi.item.THIRTEEN_KNOT_QUIPU, 1 },
}

local chipList =
{
    { xi.item.CARMINE_CHIP, 1 },
    { xi.item.CYAN_CHIP,    1 },
    { xi.item.GRAY_CHIP,    1 },
}

local advancedSingleList =
{
    xi.item.DAVOI_COFFER_KEY,
    xi.item.BEADEAUX_COFFER_KEY,
    xi.item.OZTROJA_COFFER_KEY,
    xi.item.UGGALEPIH_COFFER_KEY,
    xi.item.RANCOR_DEN_COFFER_KEY,
    xi.item.QUICKSAND_COFFER_KEY,
    xi.item.GROTTO_COFFER_KEY,
    xi.item.WARRIORS_TESTIMONY,
    xi.item.MONKS_TESTIMONY,
    xi.item.WHITE_MAGES_TESTIMONY,
    xi.item.BLACK_MAGES_TESTIMONY,
    xi.item.RED_MAGES_TESTIMONY,
    xi.item.THIEFS_TESTIMONY,
    xi.item.PALADINS_TESTIMONY,
    xi.item.DARK_KNIGHTS_TESTIMONY,
    xi.item.BEASTMASTERS_TESTIMONY,
    xi.item.BARDS_TESTIMONY,
    xi.item.RANGERS_TESTIMONY,
    xi.item.SAMURAIS_TESTIMONY,
    xi.item.NINJAS_TESTIMONY,
    xi.item.DRAGOONS_TESTIMONY,
    xi.item.SUMMONERS_TESTIMONY,
    xi.item.BLUE_MAGES_TESTIMONY,
    xi.item.CORSAIRS_TESTIMONY,
    xi.item.PUPPETMASTERS_TESTIMONY,
    xi.item.DANCERS_TESTIMONY,
    xi.item.SCHOLARS_TESTIMONY,
}

local function handleEventUpdate(player, csid, option, npc)
    if option == 10 then
        player:updateEvent(xi.item.DAMSELFLY_WORM, xi.item.MAGICKED_SKULL, xi.item.CRAB_APRON, xi.item.BLOODY_ROBE, xi.item.CUP_OF_DHALMEL_SALIVA, xi.item.WILD_RABBIT_TAIL, 0, 0)
    elseif option == 12 then
        player:updateEvent(xi.item.JADE_CRYPTEX, xi.item.SILVER_ENGRAVING, xi.item.THIRTEEN_KNOT_QUIPU, 0, 0, 0, 0, 0)
    elseif option == 13 then
        player:updateEvent(xi.item.CARMINE_CHIP, xi.item.CYAN_CHIP, xi.item.GRAY_CHIP, 0, 0, 0, 0, 0)
    elseif option == 14 then
        player:updateEvent(1, 1, 1, 1, 1, 1, player:getGil(), 1)
    end
end

local function handleSelectionEventFinish(player, csid, option, npc)
    -- Where's Tenzen?
    if
        option == 1 and
        player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.INESCAPABLE_BINDS
    then
        if quest:complete(player) then
            npcUtil.giveKeyItem(player, xi.ki.BOARDING_PERMIT)
            npcUtil.completeMission(player, xi.mission.log_id.ROV, xi.mission.id.rov.INESCAPABLE_BINDS, { nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.DESERT_WINDS } })
        end
    -- Let me think about it.
    elseif option == 2 then
        quest:setVar(player, 'Prog', 1)

    -- Purchase Boarding Permit with Gil
    elseif option == 3 then
        if player:getGil() >= 500000 then
            player:delGil(500000)
            player:messageSpecial(zones[xi.zone.LOWER_JEUNO].text.PAY_FAURSEL, 500000)
            quest:setVar(player, 'Prog', 2)
            quest:setMustZone(player)
            quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
        end
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.settings.main.ENABLE_TOAU == 1
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Faursel'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(10062)
                    end

                    return quest:progressEvent(10063, 0, 0, 0, 0, 0, player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.INESCAPABLE_BINDS and 1 or 0)
                end,
            },

            onEventUpdate =
            {
                [10063] = handleEventUpdate,
            },

            onEventFinish =
            {
                -- Hearing Faursel out grants nothing. The quest is only added to the log when 10063 ends on a selection.
                [10062] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [10063] = function(player, csid, option, npc)
                    if option == 2 or option == 3 then
                        quest:begin(player)
                    end

                    handleSelectionEventFinish(player, csid, option, npc)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Faursel'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        (
                            npcUtil.tradeMatches(trade, beginnerList) or
                            npcUtil.tradeMatches(trade, intermediateList) or
                            npcUtil.tradeMatches(trade, chipList) or
                            npcUtil.tradeSetInList(trade, advancedSingleList)
                        )
                    then
                        return quest:progressEvent(10069)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local timePassed    = quest:getVar(player, 'Timer') <= VanadielUniqueDay() and not quest:getMustZone(player)

                    -- No decision yet. Faursel reads the lists again.
                    -- Prog 0: accepted back when 10062 granted the quest.
                    if questProgress == 0 or questProgress == 1 then
                        return quest:progressEvent(10064, 0, 0, 0, 0, 0, player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.INESCAPABLE_BINDS and 1 or 0)

                    -- Purchased the Boarding Permit
                    elseif questProgress == 2 then
                        if timePassed then
                            -- Capture: the parameters 10067 starts with. Zeros end the cutscene before the fade to black.
                            return quest:progressEvent(10067, 15, 1, 3, -1, 541, 540, 0, 99)
                        else
                            return quest:event(10066) -- No refunds. Come back tomorrow.
                        end

                    -- Traded Items for Boarding Permit
                    elseif questProgress == 3 then
                        if timePassed then
                            return quest:progressEvent(10070)
                        else
                            return quest:event(10072) -- Come back tomorrow.
                        end

                    -- Purchased Permit, and has returned from Wajaom Woodlands
                    elseif questProgress == 5 then
                        return quest:progressEvent(10068)
                    end
                end,
            },

            onEventUpdate =
            {
                [10064] = handleEventUpdate,

                -- Capture: the reply to the option 30 update. The cutscene shows the key items and holds the black screen for the warp.
                [10067] = function(player, csid, option, npc)
                    if option == 30 then
                        player:updateEvent(79, 1, 0, 34, 910, 540, 99, 99)
                    end
                end,
            },

            onEventFinish =
            {
                [10064] = handleSelectionEventFinish,

                [10067] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    xi.teleport.to(player, xi.teleport.id.WAJAOM_LEYPOINT)
                end,

                [10068] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [10069] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setMustZone(player)
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,

                [10070] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        npcUtil.giveKeyItem(player, xi.ki.BOARDING_PERMIT)
                    end
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            afterZoneIn = function(player)
                -- Player won't see these messages due to teleporting at the end of the cutscene if awarded then. Display after they zone in.
                -- NOTE: Prog value of 4 is set immediately before teleporting the player.
                if quest:getVar(player, 'Prog') == 4 then
                    npcUtil.giveKeyItem(player, xi.ki.BOARDING_PERMIT)
                    npcUtil.giveKeyItem(player, xi.ki.MAP_OF_WAJAOM_WOODLANDS)
                    quest:setVar(player, 'Prog', 5)
                end
            end,
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Faursel'] = quest:event(10071):replaceDefault(),
        },
    },
}

return quest
