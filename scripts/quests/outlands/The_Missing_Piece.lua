-----------------------------------
-- The Missing Piece
-----------------------------------
-- !addquest 5 193
-- Alfesar : !pos 23.193 8.818 38.985
-- qm5
    -- Possible Positions:
        -- !pos 770, 0, -419
        -- !pos 657, 0, -537
        -- !pos 749, 0, -573
        -- !pos 451, -16, -739
        -- !pos 787, -16, -819
-- Charlaimagnat : !pos 124.560 6.500 111.787
-----------------------------------
local rabaoID = zones[xi.zone.RABAO]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)

local positionTable =
{
    [1] = { 770,   0,  -419 },
    [2] = { 657,   0,  -537 },
    [3] = { 759,   0,  -573 },
    [4] = { 451, -16,  -739 },
    [5] = { 787, -16,  -819 },
}

quest.reward =
{
    item = xi.item.SCROLL_OF_TELEPORT_ALTEP,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 4 and
                player:getMainLvl() >= 10
        end,

        [xi.zone.RABAO] =
        {
            ['Alfesar'] = quest:progressEvent(6, xi.ki.ANCIENT_TABLET_FRAGMENT),

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.RABAO] =
        {
            ['Alfesar'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(7, xi.ki.ANCIENT_TABLET_FRAGMENT) -- Reminder to get KI
                    elseif progress == 1 then
                        return quest:progressEvent(8, xi.ki.ANCIENT_TABLET_FRAGMENT, xi.ki.TABLET_OF_ANCIENT_MAGIC, xi.ki.LETTER_FROM_ALFESAR) -- Player has returned with KI
                    elseif progress == 2 then
                        return quest:event(9, 0, xi.ki.TABLET_OF_ANCIENT_MAGIC) -- Reminder to go to Sandy
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)
                    player.addKeyItem(player, xi.ki.TABLET_OF_ANCIENT_MAGIC)
                    player.addKeyItem(player, xi.ki.LETTER_FROM_ALFESAR)
                    quest:setVar(player, 'Prog', 2)
                    player:messageSpecial(rabaoID.text.ACCEPTED_KEYITEM, 0, xi.ki.TABLET_OF_ANCIENT_MAGIC, xi.ki.LETTER_FROM_ALFESAR)
                end,
            },
        },

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        local newPosition = npcUtil.pickNewPosition(npc:getID(), positionTable)
                        npc:setPos(newPosition.x, newPosition.y, newPosition.z)
                        return quest:keyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Charlaimagnat'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 2 then
                        return quest:progressEvent(703) -- Player has turned in the KIs from Alfesar
                    elseif
                        progress == 3 and
                        GetSystemTime() < quest:getVar(player, 'Wait')
                    then
                        return quest:event(704) -- Player has not waited a game day
                    elseif
                        progress == 3 and
                        GetSystemTime() >= quest:getVar(player, 'Wait')
                    then
                        return quest:progressEvent(705) -- Player has waited a game day. Quest Finished
                    end
                end,
            },

            onEventFinish =
            {
                [703] = function(player, csid, option, npc)
                    quest:setVar(player, 'Wait', GetSystemTime() + 60)
                    player:addTitle(xi.title.ACQUIRER_OF_ANCIENT_ARCANUM)
                    player:delKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
                    player:delKeyItem(xi.ki.LETTER_FROM_ALFESAR)
                    quest:setVar(player, 'Prog', 3)
                end,

                [705] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.RABAO] =
        {
            ['Alfesar'] = quest:event(11):replaceDefault(),
        },
    },
}

return quest
