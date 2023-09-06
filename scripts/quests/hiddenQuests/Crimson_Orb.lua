-----------------------------------
-- Crimson Orb
-----------------------------------
-- Wall of Banishing : !pos 181 0.1 -218 149
-- Sedal-Godjal      : !pos 185 -3 -116 149
-- Groaning Pond     : !pos 101 0.1 60 149
-- Howling Pond      : !pos 21 0.1 -258 149
-- Wailing Pond      : !pos 380 0.1 -181 149
-- Screaming Pond    : !pos -219 0.1 -101 149
-----------------------------------
local davoiID = zones[xi.zone.DAVOI]
-----------------------------------

local quest = HiddenQuest:new('CrimsonOrb')

quest.reward =
{
    keyItem = xi.ki.CRIMSON_ORB,
}

local pondNpcs =
{
    '_45g',
    '_45h',
    '_45i',
    '_45j',
}

-- The below functions handle the logic for all ponds.  NPC Offset is 0-indexed (50..53), and derived
-- from the table above.  While we set all 4 bits, the ponds themselves only care about themselves, and
-- if it is the last pond in sequence (numPonds == 3) to change the event animation.
local pondOnTrigger = function(player, npc)
    local npcName = npc:getName()
    local npcOffset = 0
    local questOption = quest:getVar(player, 'Option')
    local numPonds = utils.mask.countBits(questOption, 4)

    for offsetValue, npcListName in ipairs(pondNpcs) do
        if npcName == npcListName then
            npcOffset = offsetValue - 1
            break
        end
    end

    if
        quest:getVar(player, 'Prog') == 2 and
        not utils.mask.getBit(questOption, npcOffset)
    then
        quest:setLocalVar(player, 'npcOffset', npcOffset)
        player:messageSpecial(davoiID.text.ORB_QUEST_OFFSET)
        return quest:progressEvent(50 + npcOffset, 0, numPonds, player:getRace())
    else
        return quest:messageSpecial(davoiID.text.COLOR_OF_BLOOD)
    end
end

local pondEventFinish = function(player, csid, option, npc)
    local questOption = quest:getVar(player, 'Option')
    local npcOffset = quest:getLocalVar(player, 'npcOffset')
    local numPonds = utils.mask.countBits(questOption, 4)

    quest:setVarBit(player, 'Option', npcOffset)
    player:messageSpecial(davoiID.text.ORB_QUEST_OFFSET + numPonds + 1, 0, 0, 0, xi.ki.WHITE_ORB + numPonds + 1)
    player:delKeyItem(xi.ki.WHITE_ORB + numPonds)
    player:addKeyItem(xi.ki.WHITE_ORB + numPonds + 1)

    if numPonds == 3 then
        player:addStatusEffect(xi.effect.CURSE_I, 50, 0, 900)
        player:messageSpecial(davoiID.text.ORB_QUEST_OFFSET + 5)
        quest:setVar(player, 'Prog', 3)
    end
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return not player:hasKeyItem(xi.ki.CRIMSON_ORB)
        end,

        [xi.zone.DAVOI] =
        {
            ['_45d'] = -- Wall of Banishing
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress <= 1 then
                        quest:setVar(player, 'Prog', 1)
                        -- Intentional fallthrough to default action (Cave is sealed off)
                    elseif questProgress >= 2 then
                        return quest:messageSpecial(davoiID.text.MAY_BE_SOME_WAY_TO_BREAK)
                    end
                end,
            },

            ['_45g'] =
            {
                onTrigger = pondOnTrigger,
            },

            ['_45h'] =
            {
                onTrigger = pondOnTrigger,
            },

            ['_45i'] =
            {
                onTrigger = pondOnTrigger,
            },

            ['_45j'] =
            {
                onTrigger = pondOnTrigger,
            },

            ['Sedal-Godjal'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(24)
                    elseif questProgress == 1 then
                        return quest:progressEvent(22)
                    elseif questProgress == 2 then
                        return quest:progressEvent(21)
                    elseif questProgress == 3 then
                        return quest:progressEvent(25, 0, 0, 0, 136)
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                        npcUtil.giveKeyItem(player, xi.ki.WHITE_ORB)
                    end
                end,

                [25] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.CURSED_ORB)
                    quest:complete(player)
                end,

                [50] = pondEventFinish,
                [51] = pondEventFinish,
                [52] = pondEventFinish,
                [53] = pondEventFinish,
            },
        },
    },
}

return quest
