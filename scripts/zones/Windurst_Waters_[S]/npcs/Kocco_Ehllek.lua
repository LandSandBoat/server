-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kocco Ehllek
-- Type: Quest Giver
-- !pos -41.465 -2.125 -163.018 94
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local RedeemingRocks = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.REDEEMING_ROCKS)
    local RocksProg = player:getCharVar("RedeemingRocksProg")

    if RedeemingRocks == QUEST_AVAILABLE then
        player:startEvent(108) -- Start quest "Redeeming Rocks"
    elseif RedeemingRocks == QUEST_ACCEPTED and RocksProg == 2 then
        player:startEvent(109) -- 3rd CS quest "Redeeming Rocks"
    elseif RedeemingRocks == QUEST_ACCEPTED and RocksProg == 4 then
        player:startEvent(110) -- 4th CS quest "Redeeming Rocks"
    elseif RedeemingRocks == QUEST_ACCEPTED and player:getCharVar("RedeemingDay") ~= VanadielDayOfTheYear() then
        player:startEvent(111) -- Last CS quest "Redeeming Rocks"
    else
        player:startEvent(140) -- Standard text
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 108 then -- Finish "Redeeming Rocks" opening CS
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.REDEEMING_ROCKS)
        player:setCharVar("RedeemingRocksProg", 1)
    elseif csid == 109 then -- Finish "Redeeming Rocks" third CS
        player:setCharVar("RedeemingRocksProg", 3)
    elseif csid == 110 then -- Finish "Redeeming Rocks" fourth CS
        player:setCharVar("RedeemingRocksProg", 0)
        player:setCharVar("RedeemingDay", VanadielDayOfTheYear())
    elseif csid == 111 then -- Finish "Redeeming Rocks" quest
        npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.REDEEMING_ROCKS, {
            item = 15998,
            var = {"RedeemingDay"}
        })
    end
end
