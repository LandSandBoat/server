-----------------------------------
-- The Road to Aht Urhgan
-----------------------------------
-- Log ID: 3, Quest ID: 91
-- Faursel : !pos 37.985 3.118 -45.208 245
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_AHT_URHGAN)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
}

local beginnerList =
{
    xi.item.DAMSELFLY_WORM,
    xi.item.MAGICKED_SKULL,
    xi.item.CRAB_APRON,
    xi.item.BLOODY_ROBE,
    xi.item.CUP_OF_DHALMEL_SALIVA,
    xi.item.WILD_RABBIT_TAIL,
}

local intermediateList =
{
    xi.item.JADE_CRYPTEX,
    xi.item.SILVER_ENGRAVING,
    xi.item.THIRTEEN_KNOT_QUIPU,
}

local chipList =
{
    xi.item.CARMINE_CHIP,
    xi.item.CYAN_CHIP,
    xi.item.GRAY_CHIP,
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
        player:updateEvent(537, 538, 539, 540, 541, 542, 0, 0)
    elseif option == 12 then
        player:updateEvent(1532, 1533, 1535, 0, 0, 0, 0, 0)
    elseif option == 13 then
        player:updateEvent(1692, 1693, 1694, 0, 0, 0, 0, 0)
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
            return status == QUEST_AVAILABLE and
                xi.settings.main.ENABLE_TOAU == 1
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Faursel'] = quest:progressEvent(10062),

            onEventFinish =
            {
                [10062] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Faursel'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        (
                            npcUtil.tradeHasExactly(trade, beginnerList) or
                            npcUtil.tradeHasExactly(trade, intermediateList) or
                            npcUtil.tradeHasExactly(trade, chipList) or
                            npcUtil.tradeSetInList(trade, advancedSingleList)
                        )
                    then
                        return quest:progressEvent(10069)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local timePassed = quest:getVar(player, 'Timer') <= VanadielUniqueDay() and not quest:getMustZone(player)
                    local onRovMission = player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.INESCAPABLE_BINDS and 1 or 0

                    -- Initial Quest Dialogues
                    if questProgress == 0 then
                        return quest:progressEvent(10063, 0, 0, 0, 0, 0, onRovMission)
                    elseif questProgress == 1 then
                        return quest:progressEvent(10064, 0, 0, 0, 0, 0, onRovMission)

                    -- Purchased the Boarding Permit
                    elseif questProgress == 2 then
                        if timePassed then
                            return quest:progressEvent(10067)
                        else
                            return quest:progressEvent(10066)
                        end

                    -- Traded Items for Boarding Permit
                    elseif questProgress == 3 then
                        if timePassed then
                            return quest:progressEvent(10070)
                        else
                            return quest:progressEvent(10072)
                        end

                    -- Purchased Permit, and has returned from Wajaom Woodlands
                    elseif questProgress == 5 then
                        return quest:progressEvent(10068)
                    end
                end,
            },

            onEventUpdate =
            {
                [10063] = handleEventUpdate,
                [10064] = handleEventUpdate,
            },

            onEventFinish =
            {
                [10063] = handleSelectionEventFinish,
                [10064] = handleSelectionEventFinish,

                [10067] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    xi.teleport.to(player, xi.teleport.id.WAJAOM_LEYPOINT)
                end,

                [10068] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [10069] = function(player, csid, option, npc)
                    player:confirmTrade()
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
            afterZoneIn =
            {
                function(player)
                    -- Player won't see these messages due to teleporting at the
                    -- end of the cutscene if awarded then. Display after they zone in.
                    -- NOTE: Prog value of 4 is set immediately before teleporting the player.
                    if
                        quest:getVar(player, 'Prog') == 4
                    then
                        npcUtil.giveKeyItem(player, xi.ki.BOARDING_PERMIT)
                        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_WAJAOM_WOODLANDS)
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Faursel'] = quest:event(10071):replaceDefault(),
        },
    },
}

return quest
