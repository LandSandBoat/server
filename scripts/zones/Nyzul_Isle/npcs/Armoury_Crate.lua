-----------------------------------
-- Area:  Nyzul_Isle
-- NPC:   Armoury Crate
-- Notes: 100% drop from NMs for ??? items and ?% drop from normal mobs for Temp items
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local npcID = npc:getID()

    if
        npcID == 17092611 or
        npcID == 17092612 or
        npcID == 17092614
    then
        xi.nyzul.handleAppraisalItem(player, npc)
    else
        xi.nyzul.tempBoxTrigger(player, npc)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.nyzul.tempBoxFinish(player, csid, option, npc)
end

return entity
