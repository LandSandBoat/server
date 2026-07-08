-----------------------------------
-- A Pose By Any Other Name
-- Log ID: 2, Quest ID: 7
-- Angelica !pos -64 -9.25 -9 238
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)

local poseItems =
{
    [xi.job.WAR] = xi.item.BRONZE_HARNESS,
    [xi.job.MNK] = xi.item.ROBE,
    [xi.job.WHM] = xi.item.TUNIC,
    [xi.job.BLM] = xi.item.TUNIC,
    [xi.job.RDM] = xi.item.TUNIC,
    [xi.job.THF] = xi.item.LEATHER_VEST,
    [xi.job.PLD] = xi.item.BRONZE_HARNESS,
    [xi.job.DRK] = xi.item.BRONZE_HARNESS,
    [xi.job.BST] = xi.item.LEATHER_VEST,
    [xi.job.BRD] = xi.item.ROBE,
    [xi.job.RNG] = xi.item.LEATHER_VEST,
    [xi.job.SAM] = xi.item.KENPOGI,
    [xi.job.NIN] = xi.item.KENPOGI,
    [xi.job.DRG] = xi.item.BRONZE_HARNESS,
    [xi.job.SMN] = xi.item.TUNIC,
    [xi.job.BLU] = xi.item.ROBE,
    [xi.job.COR] = xi.item.BRONZE_HARNESS,
    [xi.job.PUP] = xi.item.TUNIC,
    [xi.job.DNC] = xi.item.LEATHER_VEST,
    [xi.job.SCH] = xi.item.TUNIC,
    [xi.job.GEO] = xi.item.TUNIC,
    [xi.job.RUN] = xi.item.BRONZE_HARNESS,
}

local poseGear =
{
    [xi.item.BRONZE_HARNESS] = 1,
    [xi.item.ROBE]           = 2,
    [xi.item.TUNIC]          = 3,
    [xi.item.LEATHER_VEST]   = 4,
    [xi.item.KENPOGI]        = 6,
}

quest.reward =
{
    fame = 75,
    fameArea = xi.fameArea.WINDURST,
    item = xi.item.COPY_OF_ANCIENT_BLOOD,
    title = xi.title.SUPER_MODEL,
    keyItem = xi.ki.ANGELICAS_AUTOGRAPH,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and player:needToZone() == false
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] =
            {
                onTrigger = function(player, npc)
                    local desiredBody = poseItems[player:getMainJob()]
                    local currentBody = player:getEquipID(xi.slot.BODY)

                    if currentBody ~= desiredBody then
                        if quest:getVar(player, 'Option') == 0 then
                            return quest:progressEvent(90)
                        else
                            return quest:progressEvent(91)
                        end
                    else
                        return quest:event(86):setPriority(101) -- If the player is wearing the requested body for their job Angelica will only return event 86 intead of cycling between 86 and 87.
                    end
                end
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Option', 0)
                    elseif option == 2 then
                        quest:setVar(player, 'Option', 1)
                    end
                end,

                [91] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] =
            {
                onTrigger = function(player, npc)
                    local requestedBody = poseItems[player:getMainJob()]

                    quest:setVar(player, 'Wait', GetSystemTime() + 3600) -- 1 Hour
                    quest:setVar(player, 'Prog', requestedBody)
                    return quest:progressEvent(92, 0, xi.item.BRONZE_HARNESS, xi.item.ROBE, xi.item.TUNIC, xi.item.LEATHER_VEST, xi.item.ROBE, xi.item.KENPOGI) -- Job check seems to be baked into the DAT.
                end,
            },
        },
    },

    -- Section: Finish quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog ~= 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] =
            {
                onTrigger = function(player, npc)
                    local requestedBody = quest:getVar(player, 'Prog')

                    if quest:getVar(player, 'Wait') >= GetSystemTime() then -- Under time. Quest completed.
                        if player:getEquipID(xi.slot.BODY) == requestedBody then
                            return quest:progressEvent(96)
                        else
                            return quest:progressEvent(94, poseGear[quest:getVar(player, 'Prog')], xi.item.BRONZE_HARNESS, xi.item.ROBE, xi.item.TUNIC, xi.item.LEATHER_VEST, xi.item.ROBE, xi.item.KENPOGI)
                        end
                    else -- Over time. Quest failed.
                        return quest:progressEvent(102)
                    end
                end,
            },

            onEventFinish =
            {
                [96] = function(player, csid, option, npc) -- Quest completed
                    if quest:complete(player) then
                        quest:setMustZone(player)
                    end
                end,

                [102] = function(player, csid, option, npc) -- Quest failed.
                    player:delQuest(xi.questLog.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'Wait', 0)
                    quest:setVar(player, 'Option', 0)
                    player:addTitle(xi.title.LOWER_THAN_THE_LOWEST_TUNNEL_WORM)
                    player:needToZone(true)
                end,
            },
        },
    },

    -- Section: Quest Completed
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(101):setPriority(101)
                    end
                end,
            },
        },
    },
}

return quest
