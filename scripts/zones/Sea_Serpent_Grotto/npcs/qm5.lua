-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: qm5 (???)
-- Quests: An Undying Pledge
-- !pos 135 -9 220
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCharVar("anUndyingPledgeCS") == 2 and
        player:getCharVar("anUndyingPledgeNM_killed") == 1
    then
        player:startEvent(18)
    elseif
        player:getCharVar("anUndyingPledgeCS") == 2 and
        player:getCharVar("anUndyingPledgeNM_killed") == 0 and
        npcUtil.popFromQM(player, npc, ID.mob.GLYRYVILU, { hide = 0 })
    then
        player:messageSpecial(ID.text.BODY_NUMB_DREAD)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 18 then
        npcUtil.giveKeyItem(player, xi.ki.CALIGINOUS_BLADE)
        player:setCharVar("anUndyingPledgeCS", 3)
        player:setCharVar("anUndyingPledgeNM_killed", 0)
    end
end

return entity
