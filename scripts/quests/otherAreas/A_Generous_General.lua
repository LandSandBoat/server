-----------------------------------
-- A Generous General
-----------------------------------
-- Log ID: 4, Quest ID: 109
-----------------------------------
-- Oldton zone !pos 566 -12 685 106
-- Faulpie     !gotoid 17719379
-- iron box    !pos -141 7 157 11
-----------------------------------
local oldtonID = zones[xi.zone.OLDTON_MOVALPOLOS]
local southernSanDoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_GENEROUS_GENERAL)

local function isWithinZoneCoordinates(player)
    local pos = player:getPos()
    return pos.x >= -323.0 and
            pos.x <= -321.0 and
            pos.y >= 6.0 and
            pos.y <= 9.0 and
            pos.z >= 261.0 and
            pos.z <= -258.0
end

quest.reward =
{
    item  = xi.item.CHOPLIXS_COIF,
    title = xi.title.MOBLIN_KINSMAN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.AN_AFFABLE_ADAMANTKING) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.AN_UNDERSTANDING_OVERLORD) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST) ~= xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'ConquestWait') == 0 and
                not player:hasItem(xi.item.CHOPLIXS_COIF) and
                player:getMainLvl() >= 60
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            onZoneIn = function(player, prevZone)
                if isWithinZoneCoordinates(player) then
                    return 60
                end
            end,

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player) -- begin quest
                    elseif option == 1 then
                        quest:setVarExpiration(player, 'ConquestWait', NextConquestTally()) -- if player declines they must wait until next conquest tally
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
            ['Faulpie'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')
                    local partsWait = quest:getVar(player, 'partsWait')
                    if prog == 0 then
                        return quest:progressEvent(770) -- tells player what items are needed
                    elseif prog == 1 then
                        return quest:event(771):importantOnce() -- reminder to get buffalo hide and sheep leather or cancel quest
                    elseif
                        prog >= 2 and
                        partsWait ~= 0 -- player is currently waiting for parts
                    then
                        if partsWait <= os.time() then
                            return quest:progressEvent(775) -- ready to go
                        else
                            return quest:event(773):importantOnce() -- player must wait till vana midnight and zone(era only)
                        end
                    elseif prog == 3 then
                        return quest:event(774):importantOnce() -- Get another part for 100000 gil or give up
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.item.BUFFALO_HIDE, xi.item.SQUARE_OF_SHEEP_LEATHER, { 'gil', 10000 } }) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(772)
                    end
                end,
            },

            onEventFinish =
            {
                [770] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [771] = function(player, csid, option, npc)
                    if option == 100 then
                        player:messageSpecial(southernSanDoriaID.text.QUEST_CANCELLED)
                        quest:cleanup(player) -- reset progress
                        player:delQuest(quest.areaId, quest.questId)
                    end
                end,

                [772] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'partsWait', getVanaMidnight())
                    player:confirmTrade()
                    player:delGil(10000)
                end,

                [774] = function(player, csid, option, npc)
                    if option == 0 then
                        if player:getGil() > 100000 then
                            quest:setVar(player, 'partsWait', getVanaMidnight())
                            player:delGil(100000)
                        else
                            player:messageSpecial(southernSanDoriaID.text.NOT_HAVE_ENOUGH_GIL)
                        end
                    elseif option == 100 then
                        player:messageSpecial(zones[player:getZoneID()].text.QUEST_CANCELLED)
                        quest:cleanup(player) -- reset progress
                        player:delQuest(quest.areaId, quest.questId)
                    end
                end,

                [775] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.GOBLIN_COIF_CUTTING) then -- only progress vars if player receives parts
                        if quest:getVar(player, 'Prog') == 2 then
                            quest:setVar(player, 'Prog', 3) -- only progress if current prog is 2, otherwise player is already at, or beyond, Prog 3
                        end

                        quest:setVar(player, 'partsWait', 0)
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            onZoneIn = function(player, prevZone)
                if
                    isWithinZoneCoordinates(player) and
                    quest:getVar(player, 'Prog') == 3 and
                    player:getEquipID(xi.slot.HEAD) == xi.item.GOBLIN_COIF
                then
                    return 61 -- Give player Goblin Recommendation Letter
                end
            end,

            ['Iron_Box'] =
            {
                onTrigger = function(player, npc)
                    if player:getEquipID(xi.slot.HEAD) ~= xi.item.GOBLIN_COIF then
                        return
                    end

                    if player:hasKeyItem(xi.ki.GOBLIN_RECOMMENDATION_LETTER) then
                        return quest:progressEvent(62)
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(63)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.item.GOBLIN_COIF }) and
                        quest:getVar(player, 'Prog') == 6
                    then
                        return quest:progressEvent(64) -- reward player with Choplix's Coif
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.GOBLIN_RECOMMENDATION_LETTER)
                    quest:setVar(player, 'Prog', 4)
                end,

                [62] = function(player, csid, option, npc)
                    local mobs = {}
                    for i = 0, 6 do
                        table.insert(mobs, oldtonID.mob.GENEROUS_GENERAL_OFFSET + i)
                    end

                    if npcUtil.popFromQM(player, npc, mobs, { claim = true, hide = 0 }) then
                        player:messageSpecial(oldtonID.text.RECOMMENDATION_LETTER)
                    end
                end,

                [63] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [64] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setVarExpiration(player, 'ConquestWait', NextConquestTally())
                        quest:setVar(player, 'generousGeneralZone', 1)
                    end
                end,
            },

            ['Goblin_Preceptor'] =
            {
                onMobDeath = function(mob, player, optParams)
                    for i = oldtonID.mob.GENEROUS_GENERAL_OFFSET, oldtonID.mob.GENEROUS_GENERAL_OFFSET + 6 do
                        DespawnMob(i)
                    end

                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                        player:delKeyItem(xi.ki.GOBLIN_RECOMMENDATION_LETTER)
                    end
                end,
            }
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            onZoneIn = function(player, prevZone)
                if
                    isWithinZoneCoordinates(player) and
                    quest:getVar(player, 'generousGeneralZone') == 1 and
                    player:getEquipID(xi.slot.HEAD) == xi.item.CHOPLIXS_COIF
                then
                    return 65
                end
            end,

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.GOLD_BEASTCOIN) then
                        quest:setVar(player, 'generousGeneralZone', 0)
                    end
                end,
            }
        },
    }
}

return quest
