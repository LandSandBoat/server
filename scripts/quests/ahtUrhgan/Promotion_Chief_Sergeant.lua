-----------------------------------
-- Promotion: Chief Sergeant
-- Logid: 6 Questid: 96
-- Abquhbah: !pos 35 -6 -58 50
-- Hagakoff: !pos 82 0 -74 50
-- Mushroom Patch:
--[[
    [1] = !pos 123 37 6 68
    [2] = !pos -359 15 -425 68
    [3] = !pos -208 9 143 68
    [4] = !pos 117 37 -46 68
    [5] = !pos -221 9 141 68
    [6] = !pos -345 15 -442 68
]]
-----------------------------------
local aydeewaID = zones[xi.zone.AYDEEWA_SUBTERRANE]
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_CHIEF_SERGEANT)
local patchStage =
{
    NONE      = 0,
    HARVESTED = 1,
    PLANTED   = 2,
    PICKED    = 3,
}
local triggerPatch = function(player, npc)
    --[[
    notes: dont have KI and havent plated, recieve KI - cs 14
    place you have picked from - cs 15
    have KI and wasnt place you picked it, lose KI - 19, option 0
    place you have plated but not ready yet - cs 20
    place you placed and ready to harvest - cs 21 {[0] = amount, [3] = bonus mushroom} option = amount recieved
    if no KI and already harvested the area - cs 18
    have KI and cant get KI from - cs 16
    ]]

    local mushroomPatchOffset = npc:getID() - aydeewaID.npc.MUSHROOM_PATCH
    local patch = 'MPatch'..mushroomPatchOffset
    local mushroomVar = quest:getVar(player, patch)
    local result = quest:messageSpecial(aydeewaID.text.NOTHING_OUT_OF_ORDINARY)
    local time = VanadielHour()

    -- Dont have KI have not picked or planted at patch
    if
        not player:hasKeyItem(xi.ki.SCOURSHROOM) and
        mushroomVar == patchStage.NONE
    then
        return quest:progressEvent(14)

    -- Section you have already Picked from
    elseif mushroomVar == patchStage.HARVESTED then
        return quest:progressEvent(15)

    -- Section Planting if have KI and has not yet been touched
    elseif
        player:hasKeyItem(xi.ki.SCOURSHROOM) and
        mushroomVar == patchStage.NONE
    then
        return quest:progressEvent(19)

    -- planted a mushroom
    elseif mushroomVar == patchStage.PLANTED then
        -- Ready to harvest
        if
            quest:getVar(player, 'MPatch_Time') <= VanadielUniqueDay() and
            not player:needToZone()
        then
            local timeBonus = 1
            local bonus = math.random(1, 100) >= 75 and 5 or 0
            if time >= 4 and time <= 6 and math.random(1, 100) >= 50 then
                timeBonus = 2
            end

            return quest:progressEvent(21, { [0] = timeBonus, [3] = bonus })
        -- Not ready to harvest
        else
            return quest:progressEvent(20)
        end

    -- Picked already
    elseif mushroomVar == patchStage.PICKED then
        return quest:progressEvent(18)

    -- player has KI and has not been harvested already
    elseif
        player:hasKeyItem(xi.ki.SCOURSHROOM) and
        mushroomVar == patchStage.NONE
    then
        return quest:progressEvent(16)
    end

    return result
end

local unsetPatches = function(player)
    for i = 0, 5 do
        local patch = 'MPatch'..i
        local patchTime = 'MPatch_Time'..i
        quest:setVar(player, patch, 0)
        quest:setVar(player, patchTime, 0)
    end
end

quest.reward =
{
    item    = xi.item.IMPERIAL_MYTHRIL_PIECE,
    keyItem = xi.ki.CS_WILDCAT_BADGE,
    title   = xi.title.CHIEF_SERGEANT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SERGEANT_MAJOR) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:progressEvent(5060),

            onEventFinish =
            {
                [5060] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        -- Started quest has a reminder, trigger Hagakoff to progress
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:progressEvent(5062):oncePerZone(),

            ['Hagakoff'] = quest:progressEvent(5067),

            onEventFinish =
            {
                [5067] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
    {
        -- Talked to Hagakoff and told to go back to Abquhbah
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:progressEvent(5068),

            onEventFinish =
            {
                [5068] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },
    {
        -- Talked to Abquhbah and told to go back to Hagakoff again
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] = quest:progressEvent(5069):oncePerZone(),

            ['Hagakoff'] = quest:progressEvent(5063),

            onEventFinish =
            {
                [5063] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 3
        end,

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['Mushroom_Patch'] =
            {
                onTrigger = function(player, npc)
                    return triggerPatch(player, npc)
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    local mushroomPatchOffset = npc:getID() - aydeewaID.npc.MUSHROOM_PATCH

                    quest:setVar(player, 'MPatch'..mushroomPatchOffset, patchStage.HARVESTED)
                    player:addKeyItem(xi.ki.SCOURSHROOM)
                end,

                [19] = function(player, csid, option, npc)
                    if option == 0 then
                        local mushroomPatchOffset = npc:getID() - aydeewaID.npc.MUSHROOM_PATCH

                        quest:setVar(player, 'MPatch'..mushroomPatchOffset, patchStage.PLANTED)
                        quest:setVar(player, 'MPatch_Time'..mushroomPatchOffset, VanadielUniqueDay() + 1)
                        player:needToZone(true)
                        player:delKeyItem(xi.ki.SCOURSHROOM)
                    end
                end,

                [21] = function(player, csid, option, npc)
                    if option ~= 100 then
                        local mushrooms = quest:getVar(player, 'Option')
                        local mushroomPatchOffset = npc:getID() - aydeewaID.npc.MUSHROOM_PATCH
                        local amount = option + mushrooms

                        if amount > 5 then
                            quest:messageSpecial(aydeewaID.text.NO_MORE_SPROUTS)
                            quest:messageSpecial(aydeewaID.text.NO_MORE_SPROUTS + 1, 0, 5)
                        end

                        quest:setVar(player, 'MPatch'..mushroomPatchOffset, patchStage.PICKED)
                        quest:setVar(player, 'Option', utils.clamp(amount, 1, 5))
                    end
                end,
            },
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    local mushrooms = quest:getVar(player, 'Option')
                    local polished = quest:getVar(player, 'Stage')

                    if mushrooms > 0 then
                        return quest:progressEvent(5061, { [0] = polished, [1] = mushrooms })
                    end
                end,
            },

            onEventFinish =
            {
                [5061] = function(player, csid, option, npc)
                    if option < 11 then
                        local polished = quest:getVar(player, 'Stage')

                        quest:setVar(player, 'Stage', quest:getVar(player, 'Option') + polished)
                        quest:setVar(player, 'Option', 0)
                        unsetPatches(player)
                    elseif option >= 20 then
                        if option >= 30 and player:getFreeSlotsCount() < 2 then
                            quest:messageSpecial(whitegateID.text.ITEM_CANNOT_BE_OBTAINED + 4)
                            return
                        end

                        if quest:complete(player) then
                            if option >= 30 then
                                npcUtil.giveItem(player, xi.item.IMPERIAL_GOLD_PIECE)
                            end

                            player:setCharVar('AssaultPromotion', 0)
                            player:messageSpecial(whitegateID.text.PROMOTION_CHIEF_SERGEANT)
                            player:delKeyItem(xi.ki.SCOURSHROOM)
                        end
                    end
                end,
            },
        },
    },
}

return quest
