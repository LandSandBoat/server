-----------------------------------
-- Area: Southern San d'Oria (230)
--  NPC: Balasiel
-- Starts and Finishes: A Squire's Test, A Squire's Test II, A Knight's Test, Methods Create Madness
-- !pos -136 -11 64 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER) == QUEST_ACCEPTED and
        player:getCharVar('KnightStalker_Progress') == 2
    then
        player:startEvent(63) -- DRG AF3 cutscene, doesn't appear to have a follow up.
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 63 then
        player:setCharVar('KnightStalker_Progress', 3)
    end
end

--    player:startEvent(32690)     -- starlight celebration

return entity
