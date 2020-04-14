-----------------------------------
-- Area: Mamook
-- NPC: Toads Footprint
-- !pos 5.9660 42.7575 -100.5741
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
require("scripts/globals/npc_util")

function onTrade(player,npc,trade)
end

function onTrigger(player, npc)
    local princeandhopper = player:getCharVar("princeandhopper")
    if  princeandhopper == 3 then
        player:startEvent(223)
    elseif  princeandhopper == 4 then
        player:messageSpecial(ID.text.DRAWS_NEAR)
        npcUtil.popFromQM(player, npc, ID.mob.MIKILULU, {hide = 30})
        npcUtil.popFromQM(player, npc, ID.mob.MIKIRURU, {hide = 30})
        npcUtil.popFromQM(player, npc, ID.mob.NIKILULU, {hide = 30})
        npcUtil.popFromQM(player, npc, ID.mob.MIKILURU, {hide = 30})
        npcUtil.popFromQM(player, npc, ID.mob.MIKIRULU, {hide = 30})
        npcUtil.popFromQM(player, npc, ID.mob.POROGGO_CASANOVA, {hide = 30})
    elseif princeandhopper == 5 then
        player:startEvent(225)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if (csid == 223) then
        player:setCharVar("princeandhopper",4)
    elseif (csid == 225) then
        player:setCharVar("princeandhopper", 6)
    end	
end
