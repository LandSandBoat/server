-----------------------------------
-- Area: Southern San d'Oria (230)
--  NPC: Balasiel
-- Starts and Finishes: A Squire's Test, A Squire's Test II, A Knight's Test, Methods Create Madness
-- !pos -136 -11 64 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
require('scripts/globals/npc_util')
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.npcGiftsNpcOnTrigger(player, 4) then
            return
        end
    end

    local lvl = player:getMainLvl()

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER) == QUEST_ACCEPTED and
        player:getCharVar("KnightStalker_Progress") == 2
    then
        player:startEvent(63) -- DRG AF3 cutscene, doesn't appear to have a follow up.
    elseif lvl >= 7 and lvl < 15 then
        player:startEvent(671)
    elseif lvl >= 15 and lvl < 30 then
        player:startEvent(670)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 63 then
        player:setCharVar("KnightStalker_Progress", 3)
    end
end

--    player:startEvent(32690)     -- starlight celebration

return entity
