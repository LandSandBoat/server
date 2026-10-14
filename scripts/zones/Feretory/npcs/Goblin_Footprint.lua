-----------------------------------
-- Area: Feretory (285)
--  NPC: Goblin Footprint
-- !pos -323.113 -2.718 -457.763 285
-----------------------------------
local ID = zones[xi.zone.FERETORY]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Grumblix asks 100 gil for his stories, but retail never takes it.
entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeMatches(trade, { { xi.item.GIL, 100 } }) then
        player:startEvent(0, -1, -1, -1, -1)
    end
end

entity.onTrigger = function(player, npc)
    player:messageText(npc, ID.text.STRANGE_RASPY_VOICE, false, 6)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 0 then
        player:updateEvent(option, -1, -1, -1)
    elseif csid == 2 then
        xi.monstrosity.updateIntroEvent(player)
    end
end

-- Event 0 answers 1 for the Monstrosity story, which replays the Feretory introduction.
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 0 and option == 1 then
        player:startEvent(2, 3, -1, -1, -1)
    elseif csid == 2 then
        player:messageText(npc, ID.text.GOBLIN_SLIPPED_AWAY, false, 6)
    end
end

return entity
