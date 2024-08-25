-----------------------------------
-- Area: Palborough Mines
--  NPC: Mythril Seam
-- Involved In Mission: Journey Abroad
-- Involved in quest: Rock Racketeer
-- !pos -68 -7 173 143
-- Rock Racketeer !pos 210 -32 -63 143
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER) ~= xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.PICKAXE)
    then
        if player:getFreeSlotsCount() > 0 then
            local isBreak = (math.random(1, 100) + (player:getMod(xi.mod.MINING_RESULT) / 10) <= xi.settings.main.MINING_BREAK_CHANCE) and 1 or 0
            if math.random() < 0.47 then
                if isBreak then
                    player:startEvent(51, 12, xi.item.CHUNK_OF_MINE_GRAVEL) -- Mine Gravel
                else
                    player:startEvent(43, 12, 0, xi.item.CHUNK_OF_MINE_GRAVEL) -- Mine Gravel but pickage breaks
                end
            else
                player:startEvent(47, 8) -- pickaxe breaks
            end
        else
            player:startEvent(53) -- cannot carry any more
        end
    else
        player:startEvent(32) -- need a pickaxe
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(30)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 51 and
        npcUtil.giveItem(player, xi.item.CHUNK_OF_MINE_GRAVEL)
    then
        return
    elseif
        csid == 43 and
        npcUtil.giveItem(player, xi.item.CHUNK_OF_MINE_GRAVEL)
    then
        player:confirmTrade()
    elseif csid == 47 then
        player:confirmTrade()
    end
end

return entity
