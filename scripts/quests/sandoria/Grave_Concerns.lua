-----------------------------------
-- Grave_Concerns
-----------------------------------
-- Log ID: 0, Quest ID: 11
-- !addquest 0 11
-- !additem 547 -- tomb guards waterskin
-- !additem 567 -- skin of well water
-- Andecia : !pos 167 0 45 230
-- Tombstone_Upper : !pos 1 0.1 -101 190
-- Well : !pos -129 -6 92 230
-----------------------------------
local sandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
local krtID      = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS)

quest.reward =
{
    fameArea = xi.fameArea.SANDORIA,
    gil      = 560,
    title    = xi.title.ROYAL_GRAVE_KEEPER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 1
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Andecia'] = function(player, npc)
                local introduction = quest:getVar(player, 'Introduction')

                if introduction == 0 then
                    return quest:progressEvent(540)
                elseif introduction == 1 then
                    return quest:progressEvent(541)
                end
            end,

            onEventFinish =
            {
                [540] = function(player, csid, option, npc)
                    quest:setVar(player, 'Introduction', 1)
                end,

                [541] = function(player, csid, option, npc)
                    if option == 0 then
                        if npcUtil.giveItem(player, xi.item.SKIN_OF_WELL_WATER) then
                            quest:begin(player)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Andecia'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.TOMB_GUARDS_WATERSKIN) and
                        quest:getVar(player, 'OfferingWaterOK') == 1
                    then
                        local droppedWaterskin = quest:getVar(player, 'DroppedWaterskin')

                        if droppedWaterskin == 0 then
                            return quest:progressEvent(558) -- I thank you adventurer (first ending)
                        elseif droppedWaterskin == 1 then
                            return quest:progressEvent(624) -- Well you lost the waterskin (second ending)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local offeringOK = quest:getVar(player, 'OfferingWaterOK')

                    if offeringOK == 0 then
                        if player:hasItem(xi.item.SKIN_OF_WELL_WATER) then
                            return quest:message(sandoriaID.text.TO_GET_TO_KING_RANPERRES) -- To get to King Ranperres... (regular reminder)
                        elseif quest:getVar(player, 'DroppedWaterskin') == 1 then
                            return quest:event(623) -- take skin from grave, fill and return (dropped item reminder)
                        else
                            quest:setVar(player, 'DroppedWaterskin', 1)

                            return quest:progressEvent(622) -- You lost the skin? Go get another one and fill it
                        end
                    elseif offeringOK == 1 then
                        return quest:message(sandoriaID.text.TO_GET_TO_KING_RANPERRES) -- To get to King Ranperres... (regular reminder)
                    end
                end,
            },

            ['Well'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'OfferingWaterOK') == 1 then
                        return quest:message(sandoriaID.text.DONT_NEED_MORE_WATER) -- You don't need more water
                    elseif
                        not player:hasItem(xi.item.SKIN_OF_WELL_WATER) and
                        npcUtil.tradeHasExactly(trade, xi.item.TOMB_GUARDS_WATERSKIN)
                    then
                        if npcUtil.giveItem(player, xi.item.SKIN_OF_WELL_WATER) then
                            player:tradeComplete()
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:message(sandoriaID.text.YOU_FIND_A_WELL) -- You find a well
                end,
            },

            onEventFinish =
            {
                [558] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,

                [624] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },

        [xi.zone.KING_RANPERRES_TOMB] =
        {

            ['Tombstone_Upper'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'OfferingWaterOK') == 0 and
                        trade:hasItemQty(xi.item.SKIN_OF_WELL_WATER, 1)
                    then
                        if npcUtil.giveItem(player, xi.item.TOMB_GUARDS_WATERSKIN) then
                            player:tradeComplete()
                            quest:setVar(player, 'OfferingWaterOK', 1)

                            return quest:messageSpecial(krtID.text.CHANGE_WATER) -- You change the water
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local offeringOK = quest:getVar(player, 'OfferingWaterOK')

                    if
                        player:hasItem(xi.item.SKIN_OF_WELL_WATER) and
                        offeringOK == 0 and
                        quest:getVar(player, 'DroppedWaterskin') == 0
                    then
                        return quest:progressEvent(2) -- A waterskin is lying here
                    elseif
                        not player:hasItem(xi.item.SKIN_OF_WELL_WATER) and
                        not player:hasItem(xi.item.TOMB_GUARDS_WATERSKIN) and
                        offeringOK == 0
                    then
                        quest:setVar(player, 'DroppedWaterskin', 1)

                        return quest:progressEvent(2) -- A waterskin is lying here
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if
                        quest:getVar(player, 'DroppedWaterskin') == 1 and
                        not player:hasItem(xi.item.SKIN_OF_WELL_WATER)
                    then
                        npcUtil.giveItem(player, xi.item.TOMB_GUARDS_WATERSKIN)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Andecia'] =
            {
                onTrigger = function(player, npc)
                    return quest:message(sandoriaID.text.I_THANK_YOU_ADVENTURER)
                end,
            },
        },
    },
}

return quest
