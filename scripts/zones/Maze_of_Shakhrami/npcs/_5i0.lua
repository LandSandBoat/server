-----------------------------------
-- Area: Maze of Shakhrami
-- NPC: Iron Door
-- !pos 247.735 18.499 -142.267
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.RUSTY_KEY) then
        player:messageSpecial(ID.text.CRUBLES_TO_DUST, 0, xi.item.RUSTY_KEY)
        player:startCutscene(41, xi.item.RUSTY_KEY)
    end
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()

    if xPos >= 248 then
        player:startCutscene(42)
    else
        player:messageSpecial(ID.text.MIGHT_BE_ABLE_TO_OPEN)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 41 then
        player:confirmTrade()
    end
end

return entity
