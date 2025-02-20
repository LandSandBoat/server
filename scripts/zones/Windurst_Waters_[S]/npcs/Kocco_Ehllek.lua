-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kocco Ehllek
-- Type: Quest Giver
-- !pos -41.465 -2.125 -163.018 94
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local redeemingRocks = player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.REDEEMING_ROCKS)
    local rocksProg = player:getCharVar('RedeemingRocksProg')

    if redeemingRocks == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(108) -- Start quest "Redeeming Rocks"
    elseif redeemingRocks == xi.questStatus.QUEST_ACCEPTED and rocksProg == 2 then
        player:startEvent(109) -- 3rd CS quest "Redeeming Rocks"
    elseif redeemingRocks == xi.questStatus.QUEST_ACCEPTED and rocksProg == 4 then
        player:startEvent(110) -- 4th CS quest "Redeeming Rocks"
    elseif
        redeemingRocks == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('RedeemingDay') ~= VanadielDayOfTheYear()
    then
        player:startEvent(111) -- Last CS quest "Redeeming Rocks"
    else
        player:startEvent(140) -- Standard text
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 108 then -- Finish 'Redeeming Rocks' opening CS
        player:addQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.REDEEMING_ROCKS)
        player:setCharVar('RedeemingRocksProg', 1)
    elseif csid == 109 then -- Finish 'Redeeming Rocks' third CS
        player:setCharVar('RedeemingRocksProg', 3)
    elseif csid == 110 then -- Finish 'Redeeming Rocks' fourth CS
        player:setCharVar('RedeemingRocksProg', 0)
        player:setCharVar('RedeemingDay', VanadielDayOfTheYear())
    elseif csid == 111 then -- Finish 'Redeeming Rocks' quest
        npcUtil.completeQuest(player, xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.REDEEMING_ROCKS, {
            item = 15998,
            var = { 'RedeemingDay' }
        })
    end
end

return entity
